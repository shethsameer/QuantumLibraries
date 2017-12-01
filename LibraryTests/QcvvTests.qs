﻿// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

namespace Microsoft.Quantum.Tests {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Convert;
    open Microsoft.Quantum.Extensions.Math;

    operation ChoiStateTest() : () {
        body {
            using (register = Qubit[2]) {
                PrepareChoiStateCA(NoOp, [register[0]], [register[1]]);
                // As usual, the same confusion about {+1, -1} and {0, 1}
                // labeling bites us here.
                Assert([PauliX; PauliX], register, Zero, "XX");
                Assert([PauliZ; PauliZ], register, Zero, "ZZ");

                ResetAll(register);
            }
        }
    }

    operation EstimateFrequencyTest () : () {
        body {
            let freq = EstimateFrequency(
                ApplyToEach(H, _),
                MeasureAllZ,
                1,
                1000
            );

            AssertAlmostEqualTol(freq, 0.5, 0.1);
        }
    }

    
    operation RobustPhaseEstimationDemo(phaseSet : Double, bitsPrecision: Int) : Double{
        body {
            let op = DiscreteOracle(RobustPhaseEstimationTestOp(phaseSet, _, _));
            mutable phaseEst = ToDouble(0);
            using (q = Qubit[1]) {
                set phaseEst = RobustPhaseEstimation(bitsPrecision, op, q);
                ResetAll(q);
            }
            return phaseEst;
        }
    }

    // Probabilistic test. Might fail occasionally
    operation RobustPhaseEstimationTest() : () {
        body {

            let bitsPrecision = 10;

            for (idxTest in 0..9) {
                let phaseSet = 2.0 * PI() * ToDouble(idxTest - 5) / 12.0;
                let phaseEst = RobustPhaseEstimationDemo(phaseSet, bitsPrecision);
                AssertAlmostEqualTol(phaseEst, phaseSet, 1e-2);
            }
        }
    }


}
