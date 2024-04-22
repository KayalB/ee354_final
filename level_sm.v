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


module level_sm(clk, reset, x_pos, y_pos, level_1_begin, init_1, pit_opening_1, pit_opened_1, pit_opening_2, pit_opened_2, spikes, spikes_opened, animation_frame_num, death);
input clk, reset;
input reg [9:0] x_pos, y_pos;
input wire death;
output level_1_begin, init_1, pit_opening_1, pit_opened_1, pit_opening_2, pit_opened_2, spikes, spikes_opened;
output reg [6:0] animation_frame_num;
// I dont think this is the correct syntax for the states
reg [3:0] state;

localparam 
    LEVEL_1_BEGIN = 4'b0000,
    INIT_1 = 4'b0001,
    PIT_OPENING_1 = 4'b0010,
    PIT_OPENED_1 = 4'b0011,
    PIT_OPENING_2 = 4'b1100,
    PIT_OPENED_2 = 4'b0101,
    SPIKES = 4'b0110,
    SPIKES_OPENED = 4'b0111,
   	UNK = 4'bXXXX;

    

always @ (posedge clk, posedge reset)
	begin
		if(reset)
			state <= LEVEL_1_BEGIN;
		else 
		begin
			case(state)
                LEVEL_1_BEGIN:
                    level_1_begin <= 1;
                    /*
                    state <= INIT_1;
                    */

				INIT_1:
					/*
                        set x_pos and y_pos
                        if death:
                            state <= LEVEL_1_BEGIN
                        else if player_x > ___:
                            animation_frame_num <= 0;
                            state <= PIT_OPENING_1
                    */

                PIT_OPENING_1:
					/*
                        animation_frame_num <= animation_frame_num + 1'b1;
                        if death:
                            state <= LEVEL_1_BEGIN
                        else:
                            if clock % 50000 == 0
                                animation_frame_num <= animation_frame_num + 1'b1;
                                if animation_frame_num == 6:
                                    state <= PIT_OPENED_1;
                    */

				PIT_OPENED_1:
					/*
                        if death:
                            state <= LEVEL_1_BEGIN
                        else if player_x > ___:
                            animation_frame_num <= 0
                            state <= PIT_OPENING_2
                    */

                PIT_OPENING_2:
					/*
                        animation_frame_num <= animation_frame_num + 1'b1;
                        if death:
                            state <= LEVEL_1_BEGIN
                        else:
                            if clock % 50000 == 0
                                animation_frame_num <= animation_frame_num + 1'b1;
                                if animation_frame_num == 6:
                                    state <= PIT_OPENED_2;
                    */

                
                PIT_OPENED_2:
					/*
                        if death:
                            state <= LEVEL_1_BEGIN
                        else if player_x > ___:
                            state <= PIT_OPENING_2
                    */

             
			endcase
		end
	end 
    
endmodule