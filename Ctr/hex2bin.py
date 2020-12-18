while(1):
    a=str(input("hex instruction: "))
    a='0x'+a
    num=eval(a)
    b=str(bin(num))
    inst=b.split('b')[1]
    ap=32-len(inst)
    for i in range(0,ap):
        inst='0'+inst
    op=inst[0:6]
    rs=inst[6:11]
    rt=inst[11:16]
    rd=inst[16:21]
    shamt=inst[21:26]
    funct=inst[26:32]
    print(inst)
    print('op: ',op)
    print('rs: ',rs)
    print('rt: ',rt)
    print('rd: ',rd)
    print('shamt: ',shamt)
    print('funct: ',funct)