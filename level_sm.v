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


module ee354_detour_sm(Clk, reset, x_pos, y_pos, level_1_begin, init_1, pit_opening_1, pit_opened_1, pit_opening_2, pit_opened_2, spikes, spikes_opened, death, );
input Clk, x_pos, y_pos, reset;
input wire death;
output init_1, pit_opening_1, pit_opened_1, pit_opening_2, pit_opened_2, spikes, spikes_opened, done;
reg [8:0] state;
assign {init_1, pit_opening_1, pit_opened_1, pit_opening_2, pit_opened_2, spikes, spikes_opened, done}=state;
localparam 
    LEVEL_1_BEGIN = 4'b0000,
    INIT_1 = 4'b0001,
    PIT_OPENING_1 = 4'b0010,
    PIT_OPENED_1 = 4'b0011,
    PIT_OPENING_2 = 4'b1100,
    PIT_OPENED_2 = 4'b0101,
    SPIKES = 4'b0110,
    SPIKES_OPENED = 4'b0111,
    DONE = 4'b1000,
   	UNK = 4'bXXXX;

    

always @ (posedge Clk, posedge reset)
	begin
		if(reset)
			state <= INIT_1;
		else 
		begin
			case(state)
                LEVEL_1_BEGIN:
                
                    /*
                    output stage info
                    state <= INIT_1;
                    */

				INIT_1:
					/*
                        output stage info
                        if death:
                            state <= LEVEL_1_BEGIN
                        else if player_x > ___:
                            state <= PIT_OPENING_1
                    */

                PIT_OPENING_1:
					/*
                        output stage info
                        if death:
                            state <= LEVEL_1_BEGIN
                        else:
                            if clock % 50000 == 0
                                subtract_x amount from pit
                            if clock == ___:
                                state <= PIT_OPENED_1;
                    */

				PIT_OPENED_1:
					/*
                        output stage info
                        if death:
                            state <= LEVEL_1_BEGIN
                        else if player_x > ___:
                            state <= PIT_OPENING_2
                    */

                PIT_OPENING_2:
					/*
                        output stage info
                        if death:
                            state <= LEVEL_1_BEGIN
                        else:
                            if clock % 50000 == 0
                                subtract_x amount from pit
                            if clock == ___:
                                state <= PIT_OPENED_2;
                    */
                
                PIT_OPENED_1:
					/*
                        output stage info
                        if death:
                            state <= LEVEL_1_BEGIN
                        else if player_x > ___:
                            state <= PIT_OPENING_2
                    */

             
			endcase
		end
	end 
    
endmodule