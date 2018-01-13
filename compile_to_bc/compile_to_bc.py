import subprocess as sb
out = sb.check_output(["cd", "-l"])
print(out)