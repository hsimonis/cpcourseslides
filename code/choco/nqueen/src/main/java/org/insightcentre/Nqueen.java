package org.insightcentre;

import org.chocosolver.solver.Model;
import org.chocosolver.solver.Solver;
import org.chocosolver.solver.variables.IntVar;

public class Nqueen {

    int[] res;
    long nrNodes;
    public Nqueen(int n) {

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
        if (solver.solve()){
            res = result(vars);
            nrNodes = solver.getNodeCount();
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
