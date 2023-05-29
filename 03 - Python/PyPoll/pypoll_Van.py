import  csv

file = "PyPoll/Resources/election_data.csv"
csv_path = file

votes = 0

candidates = {}

with open(csv_path) as csvfile:

    
    csvreader = csv.reader(csvfile, delimiter=',')
   

    csv_header = next(csvreader)


    for row in csvreader:
       

        votes += 1


        candidate = row[2]
        if candidate in candidates.keys():
            candidates[candidate] += 1
        else:
            candidates[candidate] = 1


print(votes)
print(candidates)


winner = max(candidates, key=candidates.get)
print(winner)


output = f"""Election Results
-------------------------
Total Votes: {votes}
-------------------------\n\n"""

for key in candidates.keys():
    perc =  round(100*candidates[key]/votes, 3)
    newline = f"{key}: {perc}% ({candidates[key]})\n"
    output += newline

lastline = f"""
-------------------------
Elected: {winner}
-------------------------
"""

output += lastline
print(output)




#----Create Output------------------------------------------



with open("output_pypoll_Van.txt", "w") as txt_file:
    txt_file.write(output)
