import math as math
from math import *
import xara as ops

from opensees.openseespy import *

# from RC3D1Story import RC3D1Story
# from mat import mat
# from RC3D1Story import *
from BuildRCrectSection import *
import opsvis as opsvis

import opsvis as opsvis
import matplotlib.pyplot as plt
import math as math
import winsound
import os
import os.path
import shutil
import pathlib
import time
import multiprocessing
import vfo.vfo as vfo
import SmartAnalyze

from SmartAnalyze import SmartAnalyzeTransient

# from joblib import Parallel, delayed

wipe()

# from opensees.openseespy import *

model('basic', '-ndm', 3, '-ndf', 6)



# from BuildRCrectSection import BuildRCrectSection


if __name__ == "__main__":
    from BeamSecMat40 import BeamSecMat40
    BeamSecMat40(model)
    # # # from BuildRCrectSection import BuildRCrectSection
    # # # beam sections
    # B2,B3,B4,B5,B8,B9,B16,B17  from 1-10
    BuildRCrectSection(1000, 0.40, 0.60, 0.04, 20000, 50000, 60000, 12, 0.020, 7, 5, 10, 5, 5,5)
    # B2,B3,B4,B5,B8,B9,B16,B17  from 11-40
    BuildRCrectSection(2000, 0.40, 0.60, 0.04, 20000, 50000, 60000, 14, 0.020, 8, 6, 10, 5, 5, 5)
    # B11,B13,B19,B21 from 1-40
    BuildRCrectSection(3000, 0.4, 0.60, 0.04, 20000, 50000, 60000, 20, 0.020, 10, 10, 10, 5, 5, 5)
    # B12,B20 from 1-40
    BuildRCrectSection(4000, 0.4, 0.60, 0.04, 20000, 50000, 60000, 24, 0.020, 12, 12, 10, 5, 5, 5)


    # #girder sections
    # B23,B24,B25,B26 from 1-10
    BuildRCrectSection(101, 0.55, 0.70, 0.04, 30000, 50000, 60000, 24, 0.022, 12, 12, 10, 5, 5, 5)
    # B23,B24,B25,B26 from 11-40    & B1,B6,B7,B15  from 31-40
    BuildRCrectSection(102, 0.55, 0.70, 0.04, 30000, 50000, 60000, 26, 0.022, 13, 13, 10, 5, 5, 5)
    # B1,B6,B7,B15  from 1-20
    BuildRCrectSection(103, 0.55, 0.70, 0.04, 30000, 50000, 60000, 32, 0.022, 16, 16, 10, 5, 5, 5)
    # B1,B6,B7,B15  from 21-30
    BuildRCrectSection(104, 0.55, 0.70, 0.04, 30000, 50000, 60000, 28, 0.022, 14, 14, 10, 5, 5, 5)

