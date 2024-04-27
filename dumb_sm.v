`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//
// Create Date: 02/07/2024 06:19:49 PM
// Design Name: 
// Module Name: ee3541_number_lock_verilog
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ee354_detour_sm(Clk,reset,U,Z,TIMEROUT,init,g1get,g1,g10get,g10,g101get,g101,g1011get,g1011,opening,bad);
input Clk, reset, U,Z, TIMEROUT;
output init,g1get,g1,g10get,g10,g101get,g101,g1011get,g1011,opening,bad;
reg [10:0] state;
assign {init,g1get,g1,g10get,g10,g101get,g101,g1011get,g1011,opening,bad}=state;
localparam 
    INIT = 11'b00000000001,
    G1GET = 11'b00000000010,
    G1 = 11'b00000000100,
    G10GET = 11'b00000001000,
    G10 = 11'b00000010000,
    G101GET = 11'b00000100000,
    G101 = 11'b00001000000,
    G1011GET = 11'b00010000000,
    G1011 = 11'b00100000000,
    OPENING = 11'b01000000000,
    BAD = 11'b10000000000;
    
    

always @ (posedge Clk, posedge reset)
	begin
		if(reset)
			state <= INIT;
		else 
		begin
			case(state)
				INIT:
					// dont worry about async reset here because 'if' statement considers this first
					if(U && ~Z)
						// switch left
						state <= G1GET;
					else
						// switch right
						state <= INIT;
				// these are pretty boring, just unconditionals
				G1GET:
				    if(U)
				        state <= G1GET;
                   else
                        state <= G1;	
                
                G1:
                    if(U)
                        state <= BAD;
                    else
                        if(Z)
                            state <= G10GET;
                        else
                             state <= G1;
                G10GET:
                    if(~Z)
                         state <= G10;
                    else
                        state <= G10GET;
                G10:
                    if(Z)
                         state <= BAD;
                    else
                        if(U)
                            state <= G101GET;
                G101GET:
                    if(~U)
                         state <= G101;
                G101:
                    if(Z)
                         state <= BAD;
                    else
                        if(U)
                             state <= G1011GET;
                
                G1011GET:
                    if(~U)
                         state <= G1011;
                
                G1011:
                     state <= OPENING;
                
                OPENING:
                    if(TIMEROUT)
                         state <= INIT;
                BAD:
                    if(~U && ~Z)
                        state <= INIT;
             
			endcase
		end
	end 
    
endmodule