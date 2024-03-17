import sys
from functools import reduce
import base64
 
def get_base64_encoded_image(image_path):
    with open(image_path, "rb") as img_file:
        return base64.b64encode(img_file.read()).decode('utf-8')

inp = [line.strip() for line in sys.stdin]

def parsePath(strn):
    return ['path', strn.split('/')]

def parseVal(strn):
    [k, v] = strn.split(': ')
    return [k, [int(vv) for vv in v.split(', ')]]

def parse(lst):
    return [parsePath(lst[0])] + [parseVal(v) for v in lst[2:-1]]
    
hdr = inp[0:4]
n = 7
entries = [parse(inp[i:i + n]) for i in range(5, len(inp), n)]
icons = filter(lambda ls: ls[0][1][0] == 'icons', entries)

print(""".nvicon:before {{
    content: '';
    image-rendering: pixelated;
    background: url(data:image/png;base64,{0});
    display: inline-block;
}}""".format(get_base64_encoded_image(hdr[0])))

for icon in icons:
    print(""".nvicon-{0}:before {{
    width: {1}px;
    height: {2}px;
    background-position: -{3}px -{4}px;
}}""".format(icon[0][1][-1], icon[2][1][0], icon[2][1][1], icon[1][1][0], icon[1][1][1]))
