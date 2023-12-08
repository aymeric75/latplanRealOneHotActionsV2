with open("to_be_formatted.txt", "r") as f:
    lines = f.readlines()

# Remove the first three lines
lines = lines[3:]

# # Filter out lines that contain '[t]'
lines = [line for line in lines if '[t]' not in line]

# Remove all characters of each line until '[v]'
lines = [line[line.find('[v]'):] if '[v]' in line else line for line in lines]

with open("formatted.txt", "w") as f:
    f.writelines(lines)
