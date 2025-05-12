module flpv3l_mbus_swapper (
    input      CLK, 
    input      RESETn, 
    input      DATA, 
    input      INT_FLAG_RESETn, 
    output reg LAST_CLK, 
    output reg INT_FLAG 
    );