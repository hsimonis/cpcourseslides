package org.insightcentre;

import org.chocosolver.solver.Model;
import org.chocosolver.solver.Solver;
import org.chocosolver.solver.search.strategy.Search;
import org.chocosolver.solver.search.strategy.assignments.DecisionOperatorFactory;
import org.chocosolver.solver.search.strategy.selectors.values.IntDomainMin;
import org.chocosolver.solver.search.strategy.selectors.values.IntDomainRandom;
import org.chocosolver.solver.search.strategy.selectors.variables.DomOverWDeg;
import org.chocosolver.solver.search.strategy.selectors.variables.FirstFail;
import org.chocosolver.solver.variables.IntVar;

import static org.chocosolver.solver.search.strategy.Search.*;

public class Nqueen1 {

    int[] res;
    long nrNodes;
    public Nqueen1(int n) {

        Model model = new Model(n + "-queens problem");
        IntVar[] vars = new IntVar[n];
        for (int q = 0; q < n; q++) {
            vars[q] = model.intVar("Q_" + q, 1, n);
        }
        for (int i = 0; i < n - 1; i++) {
            for (int j = i + 1; j < n; j++) {
                model.arithm(vars[i], "!=", vars[j]).post();
                model.arithm(vars[i], "!=", vars[j], "-", j - i).post();
                model.arithm(vars[i], "!=", vars[j], "+", j - i).post();
            }
        }
        Solver solver = model.getSolver();
        long seed = 1L;
        solver.limitNode(100000);
//        solver.setSearch(Search.intVarSearch(
//                        // selects the variable of smallest domain size
//                        new DomOverWDeg<>(vars,0L),//FirstFail(model),
//                        // selects the smallest domain value (lower bound)
//                        new IntDomainRandom(seed),
//                        // apply equality (var = val)
//                        DecisionOperatorFactory.makeIntEq(),
//                        // variables to branch on
//                        vars));
//        solver.setSearch(activityBasedSearch(vars));
        solver.setSearch(domOverWDegSearch(vars));
//        solver.setSearch(conflictHistorySearch(vars));
//        solver.setSearch(randomSearch(vars,42L));
        if (solver.solve()){
            res = result(vars);
            nrNodes = solver.getNodeCount();
        } else {
            System.out.println("No solution found");
        }
    }

    public int[] result(){
        return res;
    }

    public long getNrNodes(){
        return nrNodes;
    }

    private int[] result(IntVar[] vars){
        int[] res = new int[vars.length];
        for(int i=0;i<vars.length;i++){
            res[i] = vars[i].getValue();
        }
        return res;
    }

}
