module aes_core_tb;
    reg clk;
    reg reset;
    reg [127:0] data_in;
    reg [127:0] key;
    wire [127:0] data_out;
    aes_core uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .key(key),
        .data_out(data_out)
    );
    initial begin
        clk = 0;
        forever begin
            #10 clk = ~clk;
        end
    end 
    initial begin
        reset = 1;
        @(posedge clk);
        @(posedge clk);
        reset = 0;
        data_in = 128'h00112233445566778899aabbccddeeff;
        key = 128'h000102030405060708090a0b0c0d0e0f;
        @(posedge clk);
        data_in = 128'h0123456789abcdef0123456789abcdef;
        key = 128'h00112233445566778899aabbccddeeff;
        @(posedge clk);
        data_in = 128'h11111111111111111111111111111111;
        key = 128'h22222222222222222222222222222222;
        @(posedge clk);
        data_in = 128'habcdef0123456789abcdef01234567;
        key = 128'h123456789abcdef0123456789abcdef;
        @(posedge clk);
        $display("AES Core simulation done. ***");
        $finish;
    end 
endmodule