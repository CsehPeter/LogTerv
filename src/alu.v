`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:     BME
// Engineer:    Vadmacska(O5D5VN), R0ck$tar(DM5HMB)
// 
// Create Date: 17.04.2017 12:39:55
// Design Name: alu
// Module Name: alu
//////////////////////////////////////////////////////////////////////////////////

module alu
    (
        input clk,
        
        input [7:0] a,
        input [7:0] b,
        input [2:0] op,
        input cin,
        
        output reg [7:0] y,
        output reg cout,
        output reg ovf,
        output reg zero,
        output reg neg
    );
    
//PASS
wire [7:0] pass = a;

//AND
wire [7:0] y_and = a & b;

//OR
wire [7:0] y_or = a | b;

//XOR
wire op01_xor = op[0] ^ op[1];

wire [7:0] in_xor = (op[2] == 1'b1) ? {8{op01_xor}} : a;

wire [7:0] y_xor = in_xor ^ b;

//ARITH
wire [7:0] arith_in = (op[0] & op[1] == 1'b1) ? a : y_xor;

wire arith_cin = op01_xor ^ cin;

wire [8:0] y_arith = a + arith_in + arith_cin;

wire ovf_arith = (a[7] & b[7] & ~y_arith[7]) | (~a[7] & ~b[7] & y_arith[7]);

reg [8:0] r_y;
reg r_cout;
reg r_ovf;
reg r_zero;
reg r_neg;

//MUXES
always @ (*)
begin
    //Y
    case (op)
        3'b000 : r_y <= {1'b0, pass};
        3'b001 : r_y <= {1'b0, y_and};
        3'b010 : r_y <= {1'b0, y_or};
        3'b011 : r_y <= {1'b0, y_xor};
        3'b100 : r_y <= y_arith;
        3'b101 : r_y <= y_arith;
        3'b110 : r_y <= {y_arith[8], {8{1'b0}} };
        3'b111 : r_y <= y_arith;
     endcase
     
     //COUT
     r_cout <= r_y[8];
     
     //OVF
     case (op)
        3'b100 : r_ovf <= ovf_arith;
        3'b101 : r_ovf <= ovf_arith;
        3'b110 : r_ovf <= ovf_arith;
        default: r_ovf <= 1'b0;
     endcase
     
     //ZERO
     case (op)
        3'b000 : r_zero <= 1'b0;
        default: r_zero <= &r_y[7:0];
     endcase
     
     //NEG
     case (op)
         3'b000 : r_neg <= 1'b0;
         default: r_neg <= r_y[7];
     endcase
     
end

always @ (posedge clk)
begin
    y <= r_y;
    cout <= r_cout;
    ovf <= r_ovf;
    zero <= r_zero;
    neg <= r_neg;
end

    
endmodule
