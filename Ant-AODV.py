import os
import subprocess
import statistics
import csv

print(
    "This script ain't universal and follows a specific folder-file(protocol/speed/nodes) structure.\n"
    "Expected inputs are 'antaodv' anything else will crash.\n "
    "The script only analyzes all the tr files and gets the average of each run and generates a\n"
    " csvfile with Packet Delivery Ratio, Delay, Throughput and Residual Energy results based on Node-speed and Number of Nodes.\n "
)


def analyze_files(master_folder=input("Enter Folder Name With .tr Files : ")):
    dirf = os.getcwd()
    pdr_list = []
    thru_put_list = []
    avg_delay_list = []
    res_energy_list = []
    files = [
        f.name for f in os.scandir(dirf + "/" + master_folder) if f.is_dir()
    ]
    for fols in files:
        if fols in ["0.5ms", "1.5ms", "2.5ms", "3.5ms", "4.5ms"]:
            folders = [
                f.name
                for f in os.scandir(dirf + "/" + master_folder + "/" + fols)
                if f.is_dir()
            ]
            for nodes in folders:
                tr_files = [
                    f.name for f in os.scandir(dirf + "/" + master_folder +
                                               "/" + fols + "/" + nodes)
                ]
                pdr_vals = []
                thru_put_vals = []
                avg_delay_vals = []
                res_energy_vals = []

                for file in tr_files:
                    #PDR analysis of files on either of the base folders
                    if master_folder == "antnet":
                        proc = subprocess.check_output([
                            "perl", "antnetanalizer.pl",
                            "{dirf}/{master_folder}/{fols}/{nodes}/{file}".
                            format(dirf=dirf,
                                   master_folder=master_folder,
                                   fols=fols,
                                   nodes=nodes,
                                   file=file)
                        ])

                    else:
                        proc = subprocess.check_output([
                            "perl", "analyzeaomdv.pl",
                            "{dirf}/{master_folder}/{fols}/{nodes}/{file}".
                            format(dirf=dirf,
                                   master_folder=master_folder,
                                   fols=fols,
                                   nodes=nodes,
                                   file=file)
                        ])
                    raw = proc.decode('utf8').replace(
                        "\t\t",
                        "",
                    ).replace("\n", ", ")
                    pdr = float(raw.split(",")[5].split(":")[1])
                    pdr_vals.append(pdr)

                    #Average delay analysis
                    avg_delay = subprocess.Popen([
                        "awk", "-f", dirf + "/Delay.pl",
                        "{dirf}/{master_folder}/{fols}/{nodes}/{file}".format(
                            dirf=dirf,
                            master_folder=master_folder,
                            fols=fols,
                            nodes=nodes,
                            file=file)
                    ],
                                                 stdout=subprocess.PIPE,
                                                 stderr=subprocess.STDOUT)
                    avg_delay_data = avg_delay.stdout.readlines()[0].decode(
                        "utf-8").rstrip("\n").replace(" overall",
                                                      '').split(':')
                    avg_delay_dict = {
                        avg_delay_data[0].replace(' ', ''):
                        float(avg_delay_data[1])
                    }
                    avg_del_val = avg_delay_dict.get('avgDelay[ms]')
                    if avg_del_val is not None:
                        avg_delay_vals.append(avg_del_val)
                    # print(avg_delay_dict)

                    #Throughput analysis of files on either of the base folders begins here
                    thru_put = subprocess.Popen([
                        "awk", "-f", dirf + "/Throughput.awk", "pkt=1000",
                        "{dirf}/{master_folder}/{fols}/{nodes}/{file}".format(
                            dirf=dirf,
                            master_folder=master_folder,
                            fols=fols,
                            nodes=nodes,
                            file=file)
                    ],
                                                stdout=subprocess.PIPE,
                                                stderr=subprocess.STDOUT)
                    avg_thru_put_data = thru_put.stdout.readlines()[4].decode(
                        "utf-8").rstrip("\n").split(':')
                    avg_dict = {
                        avg_thru_put_data[0].replace(' ', ''):
                        float(avg_thru_put_data[1])
                    }
                    val = avg_dict.get('avgTput[kbps]')
                    if val is not None:
                        thru_put_vals.append(val)

                    #Residual energy analysis
                    res_energy = subprocess.Popen([
                        "awk", "-f", dirf + "/Residual_Energy.awk",
                        "{dirf}/{master_folder}/{fols}/{nodes}/{file}".format(
                            dirf=dirf,
                            master_folder=master_folder,
                            fols=fols,
                            nodes=nodes,
                            file=file)
                    ],
                                                  stdout=subprocess.PIPE,
                                                  stderr=subprocess.STDOUT)
                    res_energy_data = res_energy.stdout.readlines()[0].decode(
                        "utf-8").rstrip("\n").split(":")
                    # print(res_energy_data)
                    res_energy_dict = {
                        res_energy_data[0].rstrip("  \t\t").replace(" ", "_"):
                        float(res_energy_data[1])
                    }
                    res_energy_val = res_energy_dict.get(
                        'Average_residual_energy')
                    if res_energy_val is not None:
                        res_energy_vals.append(res_energy_val)

                #calculating the pdr mean and printing the output
                pdr_mean = [fols, nodes, statistics.mean(pdr_vals)]
                pdr_list.append(pdr_mean)
                print("{} ::AVG Packet Delivery Ratio".format(pdr_mean))
                #
                # 			#calculating the Throughput mean and printing the output
                thru_put_mean = [fols, nodes, statistics.mean(thru_put_vals)]
                thru_put_list.append(thru_put_mean)
                print("{} ::AVG Throughput".format(thru_put_mean))
                #
                # 			# calculating the avarage delay mean
                # 			# print(avg_delay_vals)
                avarage_delay_mean = [
                    fols, nodes, statistics.mean(avg_delay_vals)
                ]
                avg_delay_list.append(avarage_delay_mean)
                print("{} ::AVG Delay".format(avarage_delay_mean))
                # 			#
                # 			# #calculating the residual energy mean
                res_energy_mean = [
                    fols, nodes, statistics.mean(res_energy_vals)
                ]
                res_energy_list.append(res_energy_mean)
                print("{} ::AVG Residual Energy".format(res_energy_mean))
    #
    # # #writing into pdr.csv file
    with open("{dirf}/{master_folder}/pdr.csv".format(
            dirf=dirf, master_folder=master_folder),
              'w',
              newline='') as csvfile:
        wr = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        wr.writerow(pdr_list)
    # #
    # # #writing into thru_put.csv file
    with open("{dirf}/{master_folder}/thru_put.csv".format(
            dirf=dirf, master_folder=master_folder),
              'w',
              newline='') as csvfile:
        wr = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        wr.writerow(thru_put_list)
    # #
    # # #writing to the avg_delay.csv files
    with open("{dirf}/{master_folder}/avg_delay.csv".format(
            dirf=dirf, master_folder=master_folder),
              'w',
              newline='') as csvfile:
        wr = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        wr.writerow(avg_delay_list)
    # #
    # # #writing to the res_energy.csv
    with open("{dirf}/{master_folder}/res_energy.csv".format(
            dirf=dirf, master_folder=master_folder),
              'w',
              newline='') as csvfile:
        wr = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        wr.writerow(res_energy_list)


if __name__ == "__main__":
    analyze_files()
