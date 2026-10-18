`timescale 1ns/1ps

module mac_seq_b #(parameter W = 8, parameter N = 9) (
    input logic clk,
    input logic reset_n,
    input logic load_weight,
    input logic signed [W-1:0] weight_in,
    input logic signed [W-1:0] data_in,
    output logic signed [2*W+4:0] mac_out,
    output logic out_valid
);

    logic signed [W-1:0] kernel_buff [0:N-1];
    integer load_idx;
    integer comp_idx;

    logic signed [2*W-1:0] mult_result;
    logic signed [2*W+4:0] accumulator;

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            load_idx   <= 0;
            comp_idx   <= 0;
            accumulator <= '0;
            mac_out    <= '0;
            out_valid  <= 0;
        end
        else begin
            out_valid <= 0;

            if (load_weight) begin
                if (load_idx < N) begin
                    kernel_buff[load_idx] <= weight_in;
                    load_idx <= load_idx + 1;
                end
            end
            else if (load_idx == N && comp_idx < N) begin
                accumulator <= accumulator +
                    ($signed(kernel_buff[comp_idx]) * $signed(data_in));

                comp_idx <= comp_idx + 1;

                if (comp_idx == N-1) begin
                    mac_out <= accumulator +
                        ($signed(kernel_buff[comp_idx]) * $signed(data_in));
                    out_valid <= 1;
                end
            end
        end
    end

endmodule
