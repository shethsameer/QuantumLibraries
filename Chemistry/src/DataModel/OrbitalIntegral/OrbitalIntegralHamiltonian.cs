﻿// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

using System;
using System.Collections.Generic;

using Microsoft.Quantum.Chemistry.Hamiltonian;

namespace Microsoft.Quantum.Chemistry.OrbitalIntegrals
{
 
    public class OrbitalIntegralHamiltonian : GenericHamiltonian<TermType.OrbitalIntegral, OrbitalIntegral, DoubleCoeff>
    {
        /// <summary>
        /// Constructor for empty orbital integral Hamiltonian.
        /// </summary>
        public OrbitalIntegralHamiltonian() : base() {}

        /// <summary>
        /// Method for adding an orbital integral term to a Hamiltonian.
        /// </summary>
        /// <param name="orbitalIntegral">Orbital integral to add to Hamiltonian.</param>
        public void AddTerm(OrbitalIntegral orbitalIntegral)
        {
            AddTerm(orbitalIntegral, orbitalIntegral.Coefficient.ToDouble());
        }

        /// <summary>
        /// Method for adding multiple orbital integrals to a Hamiltonian.
        /// </summary>
        /// <param name="orbitalIntegral">Orbital integrals to add to Hamiltonian.</param>
        public void AddTerms(IEnumerable<OrbitalIntegral> terms)
        {
            foreach (var term in terms)
            {
                AddTerm(term);
            }
        }

        /// <summary>
        /// Method for collecting all distinct system (orbital) indices.
        /// </summary>
        /// <param name="orbitalIntegral">Collate orbital indices from this orbital integral.</param>
        public override void AddToSystemIndices(OrbitalIntegral index)
        {
            foreach(var idx in index.OrbitalIndices)
            {
                systemIndices.Add(idx);
            }
        }
    }

     
}
 