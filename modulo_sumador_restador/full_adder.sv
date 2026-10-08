module fa(
    input logic a, b, 
    input logic cin, 
    output logic s, 
    output logic cout
);
    // creo la salida interna de carry (tiene que ser un vector)
    logic p, g;

    assign p = a ^ b;
    assign g = a & b;
    assign s = p ^ cin;
    assign cout = g | (p & cin);
endmodule