# DSP_ACMC
Function oc Antenna Calibration by Mutual Coupling (License)
Background: 
  1. AC signal path from Transmitter to Antenna Array(Antenna S-parameters) to Receiver
  2. All of the path including of Transmitter, Antenna array and Recveiver would contribute the phase shifter
  3. To calculate the phase shifters of each patch by algorithm of Least Squares
  4. To calculate the phase shifters with formula Y = T*S*R, Matrix of T: transmitter, S: antenna array, R: receiver 
  5. Y and S is known by measurement, T and R are calculated by Least Squares with iteration.

Experiment:
  - 1. Setup initialized parameters:
    - a. AC parameters
    - b. Tx impariment matrix
    - c. Rx impariment matrix
    - d. Antenna S matrix
    - e. output: Y matrix

  - 2. Initializtion
    - step1, setup initial Tx or Rx (initialized parameters could be Anything)

  - 3. Calculation:
    - prioritySolve 'TX':
    - step1, generate Ynm matrix : [Y21;Y31;Y41;...;Y12;Y32;Y42;...;Y13;Y23;Y43;...;Y14;Y24;Y34;...], for LS solve
    - step2a, steup TmEst -> step2b, generate TmSnmEst -> step2c, solve RnEst -> step4, resolve TmEst
    - step2b, generate TmSnmEst
    - step2c, solve RnEst

    - prioritySolve 'RX':
    - step2a, steup RnEst -> step3, generate RnSnmEst -> step4, solve TmEst -> step5, resolve RnEst
    - step3, generate RnSnmEst
    - step4, solve TmEst
    - step5, resolve Rn
    - step5a, generate TmSnmEst
    - step5b, resolve RnEst

    - After RnEst and TnEst solved
    - step6, compare Estimation result with previous Estimation settings
    - step7, update phase estimation and iteration again
    - Repeat initialization and iteration solving until convergence
 
  - 4. Results: the phase estimation error < 0.003 
  ![image](https://user-images.githubusercontent.com/87049112/141934318-b11dd062-8efd-45c9-a90a-590c55f4b130.png)
  
  - 5. Add HW impariment for analysis ??? (Not yet done)
    - SNR
    - LO Phase noise, phase shifter, imbalanced...
    - Interference
    - Signal leakage
    - Antenna array accuracy
    - Environment
    - System error, timing...













