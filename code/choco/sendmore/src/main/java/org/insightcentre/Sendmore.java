package org.insightcentre;

import org.chocosolver.solver.Model;
import org.chocosolver.solver.Solver;
import org.chocosolver.solver.variables.IntVar;

public class Sendmore {
    int[] res;
    public Sendmore() {
        Model model = new Model("SEND+MORE=MONEY");
        IntVar S = model.intVar("S", 1, 9, false);
        IntVar E = model.intVar("E", 0, 9, false);
        IntVar N = model.intVar("N", 0, 9, false);
        IntVar D = model.intVar("D", 0, 9, false);
        IntVar M = model.intVar("M", 1, 9, false);
        IntVar O = model.intVar("0", 0, 9, false);
        IntVar R = model.intVar("R", 0, 9, false);
        IntVar Y = model.intVar("Y", 0, 9, false);
        IntVar[] vars = new IntVar[]{S, E, N, D, M, O, R, Y};

        model.allDifferent(vars).post();

        IntVar[] ALL = new IntVar[]{
                S, E, N, D,
                M, O, R, E,
                M, O, N, E, Y};
        int[] COEFFS = new int[]{
                1000, 100, 10, 1,
                1000, 100, 10, 1,
                -10000, -1000, -100, -10, -1};
        model.scalar(ALL, COEFFS, "=", 0).post();

        Solver solver = model.getSolver();
        solver.showStatistics();
        solver.showSolutions();
        if (solver.solve()) {
            res = result(vars);
        }
    }

    public int[] result(){
        return res;
    }

    private int[] result(IntVar[] vars){
        int[] res = new int[vars.length];
        for(int i=0;i<vars.length;i++){
            res[i] = vars[i].getValue();
        }
        return res;
    }
}
