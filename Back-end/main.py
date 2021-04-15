import ctypes
import pathlib

if __name__ == "__main__":
    libname = pathlib.Path().absolute() / "matrix.h"
    c_lib = ctypes.CDLL(libname)
    c_lib.matrixGameSolver()