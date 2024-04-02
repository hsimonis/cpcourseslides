package org.insightcentre;

import org.chocosolver.solver.Model;
import org.chocosolver.solver.Solver;
import org.chocosolver.solver.variables.IntVar;

public class Main {
    public static void main(String[] args) {
        int[][] data = new int[][]{
            {4, 0, 8, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 1, 7, 0, 0, 0, 0},
            {0, 0, 0, 0, 8, 0, 0, 3, 2},
            {0, 0, 6, 0, 0, 8, 2, 5, 0},
            {0, 9, 0, 0, 0, 0, 0, 8, 0},
            {0, 3, 7, 6, 0, 0, 9, 0, 0},
            {2, 7, 0, 0, 5, 0, 0, 0, 0},
            {0, 0, 0, 0, 1, 4, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 6, 0, 4}
        };

        int[][] result = new Sudoku(data).result();
        showMatrix(result);

    }

    private static void showMatrix(int[][] result){
        for (int[] ints : result) {
            for (int v:ints) {
                System.out.printf(v + " ");
            }
            System.out.println();
        }
    }
}