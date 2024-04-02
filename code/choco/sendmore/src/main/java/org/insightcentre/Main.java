package org.insightcentre;

public class Main {
    public static void main(String[] args) {
        int[] result = new Sendmore().result();
        showVector(result);
    }

    private static void showVector(int[] result) {
        for (int v : result) {
            System.out.printf("%d ", v);
        }
        System.out.println();
    }
}