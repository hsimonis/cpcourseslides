package org.insightcentre;

import org.chocosolver.solver.Model;
import org.chocosolver.solver.Solver;
import org.chocosolver.solver.variables.IntVar;

public class Sudoku {
    int[][] res;
    public Sudoku(int[][] data){
        Model model = new Model("Sudoku");
        int m = data.length;
        int blockSize = intSqrt(m);

        IntVar[][] vars = new IntVar[m][m];
        for(int i=0;i<m;i++){
            for(int j=0;j<m;j++){
                vars[i][j] =  model.intVar("X"+i+""+j, 1, m);
                if (data[i][j]>0) {
                    model.arithm(vars[i][j],"=",data[i][j]).post();
                }
            }
        }
        for(int i=0;i<m;i++){
            model.allDifferent(row(i,m,vars)).post();
            model.allDifferent(column(i,m,vars)).post();
        }
        for(int i=0;i<m;i+=blockSize){
            for(int j=0;j<m;j+=blockSize){
                model.allDifferent(block(i,j,blockSize,vars)).post();
            }
        }
        Solver solver = model.getSolver();
        if (solver.solve()){
            res = result(vars);
        }
    }

    public int[][] result(){
        return res;
    }

    IntVar[] row(int row, int size, IntVar[][] array){
        return array[row];
    }

    IntVar[] column(int col,int size,IntVar[][] array){
        IntVar[] column = new IntVar[size];
        for(int i=0; i<size; i++){
            column[i] = array[i][col];
        }
        return column;
    }

    IntVar[] block(int x,int y,int blockSize,IntVar[][] array){
        IntVar[] block = new IntVar[blockSize*blockSize];
        int k=0;
        for(int i=0;i<blockSize;i++){
            for(int j=0;j<blockSize;j++){
                block[k++] = array[x+i][y+j];
            }
        }
        return block;
    }

    private int[][] result(IntVar[][] vars){
        int m = vars.length;
        int[][] res = new int[m][m];
        for(int i=0;i<m;i++){
            for(int j=0;j<m;j++){
                res[i][j] = vars[i][j].getValue();
            }
        }
        return res;
    }

    private int intSqrt(int sqr){
        return (int) Math.round(Math.sqrt(sqr));
    }

}
