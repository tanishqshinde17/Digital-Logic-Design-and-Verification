`timescale 1ns/1ps

module tb_mac_seq_b;

    parameter W = 8;
    parameter N = 9;

    logic clk = 0;
    logic reset_n = 0;
    logic load_weight = 0;
    logic signed [W-1:0] weight_in;
    logic signed [W-1:0] data_in;
    logic signed [2*W+4:0] mac_out;
    logic out_valid;

    integer i;
    integer expected;

    mac_seq_b #(W, N) dut (
        .clk(clk),
        .reset_n(reset_n),
        .load_weight(load_weight),
        .weight_in(weight_in),
        .data_in(data_in),
        .mac_out(mac_out),
        .out_valid(out_valid)
    );

    always #5 clk = ~clk;

    initial begin
        weight_in = 0;
        data_in = 0;
        expected = 0;

        repeat (2) @(posedge clk);
        reset_n = 1;

        // Load 9 weights: 1,2,3,4,5,6,7,8,9
        @(negedge clk);
        load_weight = 1;
        weight_in = 1;

        for (i = 1; i < N; i = i + 1) begin
            @(negedge clk);
            weight_in = i + 1;
        end

        @(negedge clk);
        load_weight = 0;

        // Stream 9 data values: 1,2,3,4,5,6,7,8,9
        for (i = 1; i <= N; i = i + 1) begin
            data_in = i;
            expected = expected + (i * i);
            @(negedge clk);
        end

        #1;

        if (out_valid && mac_out == expected)
            $display("PASS: output=%0d expected=%0d", mac_out, expected);
        else
            $display("FAIL: output=%0d expected=%0d valid=%b",
                     mac_out, expected, out_valid);

        #10;
        $finish;
    end

endmodule
