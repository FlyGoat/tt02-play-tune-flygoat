`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

module tb (
    // testbench is controlled by test.py
    input clk,
    input rst,
    input [1:0] db_sel_in,
    output [1:0] speaker,
    output [3:0] led_out
    );

    // this part dumps the trace to a vcd file that can be viewed with GTKWave
    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // wire up the inputs and outputs
    wire [7:0] inputs = {6'b0, db_sel_in, rst, clk};
    wire [7:0] outputs;
    assign speaker = outputs[1:0];
    assign led_out = outputs[5:2];

    // instantiate the DUT
    flygoat_tt02_play_tune #(.MAX_COUNT(100)) flygoat_tt02_play_tune(
        .io_in  (inputs),
        .io_out (outputs)
        );

endmodule
