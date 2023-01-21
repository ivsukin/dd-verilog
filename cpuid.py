import ctypes

library = ctypes.CDLL("./cpuid.dll")

class Registers(ctypes.Structure):
    _fields_ = [("eax", ctypes.c_uint),
                ("ebx", ctypes.c_uint),
                ("ecx", ctypes.c_uint),
                ("edx", ctypes.c_uint)]

r = Registers()
rp = ctypes.pointer(r)

def bitmask(value, start, end):
    mask = 1
    for _ in range(end - start):
        mask <<= 1
        mask += 1
    return ((value >> start) & mask)

def cpuid(eax=0, ebx=0, ecx=0, edx=0):
    r.eax = eax
    r.ebx = ebx
    r.ecx = ecx
    r.edx = edx
    library.cpuid(rp)
    return (r.eax, r.ebx, r.ecx, r.edx)

class CPU:
    def __init__(self):
        self.maxEAX, ebx, ecx, edx = cpuid()
        self.maxExtEAX, _, _, _ = cpuid(0x80000000)
        self.manufacturerID = ''
        for reg in (ebx, edx, ecx):
            for i in range(4):
                self.manufacturerID += chr(bitmask(reg, 8 * i, 8 * i + 7))
        for eax in range(1, self.maxEAX
                         + 1):
            pass

    def __repr__(self):
        res = f"Manufacturer ID: {self.manufacturerID}\n"
        res += f"Maximum EAX value for calling CPUID: {hex(self.maxEAX)}\n"
        res += f"Maximum extended EAX value: {hex(self.maxExtEAX)}\n"
        return res


a = CPU()
print(a)
