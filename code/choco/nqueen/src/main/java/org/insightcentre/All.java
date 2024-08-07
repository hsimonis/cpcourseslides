package org.insightcentre;

public class All {
    public static void main(String[] args) {
        for(int i=4;i<=200;i++) {
            Nqueen1 run = new Nqueen1(i);
            if (run.result()!= null) {
                int[] res = run.result();
                long nrNodes = run.getNrNodes();
                System.out.print(i + " - " + nrNodes + " - ");
                showVector(res);
            }
        }
    }

    private static void showVector(int[] result) {
        for (int v : result) {
            System.out.printf("%d ", v);
        }
        System.out.println();
    }

}