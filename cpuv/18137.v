module tristate(
    assign din = dio;
    assign dio = dsel ? dout : 8'bz;