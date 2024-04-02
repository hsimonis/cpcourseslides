package org.insightcentre;

public class Main {
    public static void main(String[] args) {
        int[] res = new Nqueen(8).result();
        showVector(res);
    }

    private static void showVector(int[] result) {
        for (int v : result) {
            System.out.printf("%d ", v);
        }
        System.out.println();
    }

}