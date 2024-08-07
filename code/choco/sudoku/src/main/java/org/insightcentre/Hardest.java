package org.insightcentre;

public class Hardest {
    public static void main(String[] args) {
        int[][] data = new int[][]{
            {8, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 3, 6, 0, 0, 0, 0, 0},
            {0, 7, 0, 0, 9, 0, 2, 0, 0},
            {0, 5, 0, 0, 0, 7, 0, 0, 0},
            {0, 0, 0, 0, 4, 5, 7, 0, 0},
            {0, 0, 0, 1, 0, 0, 0, 3, 0},
            {0, 0, 1, 0, 0, 0, 0, 6, 8},
            {0, 0, 8, 5, 0, 0, 0, 1, 0},
            {0, 9, 0, 0, 0, 0, 4, 0, 0}
        };

        int[][] result = new Sudoku1(data,"AC").result();
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