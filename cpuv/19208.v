module sub (
    input wreal wr
);
initial begin
    if (wr != 1.1)
        $stop;
end
endmodule