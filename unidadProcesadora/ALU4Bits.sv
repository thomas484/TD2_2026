module ALU4Bits (
    input logic [3:0] a, b,
    input logic [3:0] ALUControl, 
    output logic [3:0] Res, Vflags
);

logic cin,cout,neg,zero,carry,overflow; 
logic [3:0] y, sum;

assign cin = ALUControl[0]; // si es 1, resta, sino suma 
always_comb begin
    casex (ALUControl[3:0])
    4'b?00?: y = 4'b0000; //SOLO TRANSFERENCIA DE A
    4'b?01?: y = b; //LE ASIGNA B A Y 
    4'b?10?:  y = ~b; //LE ASIGNA B COMPLEMENTADO A Y PARA RESTA CON CIN =1
    4'b?11?: y = 4'b1111; //LE ASIGNA Y A 1111 PARA RESTA CON CIN =1, FINALMNTE RESULTA UNA TRANSFERENCIA DE A
    endcase 
end 
assign {cout, sum} = a + y + cin; // si es resta, sumo 1 al carry de entrada que vale 1 y me completa el complemento a 2

//selecciono la salida de la ALU según la palabra de control ALUControl[3:1]
always_comb begin
    casex (ALUControl[3:0]) //si ALUControl[3] es 0, es suma o resta, si es 1, es AND o OR

    4'b0???:  Res = sum; //suma o resta
    4'b100?: Res = a | b; //OR
    4'b101?: Res = a & b; //AND
    4'b110?: Res = a ^ b; //XOR 
    4'b111?: Res = ~b;  // NOT B 
    endcase 
end

assign neg = Res[3]; //negativo si el bit de signo es 1
assign zero = Res == 4'b0000; 
assign carry = (ALUControl[3] == 1'b0) & cout; // carry solo para suma o resta aritmetica, si es AND o OR no hay carry
assign overflow = (ALUControl[3] == 1'b0) & ~(a[3] ^ y[3]) & (a[3] ^ sum[3]); 
assign Vflags = {overflow, neg, zero, carry};

endmodule