product = {
        'NT-5006-DM2-0000': '6Port_1000M_Burst', 
        'NT-110FX2-ST-0000': '8Port_100M_Burst',
}

file_num_ports = {
        '3Port_100M_Burst': 3,
        '4Port_100M_Burst': 4,
        '5Port_100M_Burst': 5,
        '6Port_100M_Burst': 6,
        '8Port_100M_Burst': 8,
        '3Port_1000M_Burst': 3,
        '4Port_1000M_Burst': 4,
        '5Port_1000M_Burst': 5,
        '6Port_1000M_Burst': 6,
        '8Port_1000M_Burst': 8,
}

patch = {
    'A':
    [
        {"port_id": "//10.11.1.3/1/1", "port_num": 0},
        {"port_id": "//10.11.1.3/1/2", "port_num": 1},
        {"port_id": "//10.11.1.3/1/3", "port_num": 2},
        {"port_id": "//10.11.1.3/1/4", "port_num": 3},
        {"port_id": "//10.11.1.3/1/5", "port_num": 4},
        {"port_id": "//10.11.1.3/1/6", "port_num": 5},
        {"port_id": "//10.11.1.3/1/7", "port_num": 6},
        {"port_id": "//10.11.1.3/1/8", "port_num": 7},
    ],
    'B':
    [
        {"port_id": "//10.11.1.3/3/9", "port_num": 0},
        {"port_id": "//10.11.1.3/3/10", "port_num": 1},
        {"port_id": "//10.11.1.3/3/11", "port_num": 2},
        {"port_id": "//10.11.1.3/3/12", "port_num": 3},
        {"port_id": "//10.11.1.3/4/1", "port_num": 4},
        {"port_id": "//10.11.1.3/4/2", "port_num": 5},
        {"port_id": "//10.11.1.3/4/3", "port_num": 6},
        {"port_id": "//10.11.1.3/4/4", "port_num": 7},
    ],
    'C':
    [
        {"port_id": "//10.11.1.3/2/1", "port_num": 0},
        {"port_id": "//10.11.1.3/2/2", "port_num": 1},
        {"port_id": "//10.11.1.3/2/3", "port_num": 2},
        {"port_id": "//10.11.1.3/2/4", "port_num": 3},
        {"port_id": "//10.11.1.3/2/5", "port_num": 4},
        {"port_id": "//10.11.1.3/2/6", "port_num": 5},
        {"port_id": "//10.11.1.3/2/7", "port_num": 6},
        {"port_id": "//10.11.1.3/2/8", "port_num": 7},
    ],
    'D':
    [
        {"port_id": "//10.11.1.3/1/9", "port_num": 0},
        {"port_id": "//10.11.1.3/1/10", "port_num": 1},
        {"port_id": "//10.11.1.3/1/11", "port_num": 2},
        {"port_id": "//10.11.1.3/1/12", "port_num": 3},
        {"port_id": "//10.11.1.3/2/9", "port_num": 4},
        {"port_id": "//10.11.1.3/2/10", "port_num": 5},
        {"port_id": "//10.11.1.3/2/11", "port_num": 6},
        {"port_id": "//10.11.1.3/2/12", "port_num": 7},
    ],
    'E':
    [
        {"port_id": "//10.11.1.3/3/1", "port_num": 0},
        {"port_id": "//10.11.1.3/3/2", "port_num": 1},
        {"port_id": "//10.11.1.3/3/3", "port_num": 2},
        {"port_id": "//10.11.1.3/3/4", "port_num": 3},
        {"port_id": "//10.11.1.3/3/5", "port_num": 4},
        {"port_id": "//10.11.1.3/3/6", "port_num": 5},
        {"port_id": "//10.11.1.3/3/7", "port_num": 6},
        {"port_id": "//10.11.1.3/3/8", "port_num": 7},
    ],
    'F':
    [
        {"port_id": "//10.11.1.3/5/1", "port_num": 0},
        {"port_id": "//10.11.1.3/5/2", "port_num": 1},
        {"port_id": "//10.11.1.3/5/3", "port_num": 2},
        {"port_id": "//10.11.1.3/5/4", "port_num": 3},
        {"port_id": "//10.11.1.3/5/5", "port_num": 4},
        {"port_id": "//10.11.1.3/5/6", "port_num": 5},
        {"port_id": "//10.11.1.3/5/7", "port_num": 6},
        {"port_id": "//10.11.1.3/5/8", "port_num": 7},
    ],
}

# 08DEC237026TX$09    
# Format is always <7 char date><model>$<num>
#   - We should look to parse out the model
