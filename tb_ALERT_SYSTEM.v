module tb_ALERT_SYSTEM;

    // Inputs
    reg clk;
    reg rst;
    reg DOOR_STATUS;
    reg WEIGHT_STATUS;

    // Outputs
    wire DOOR_ALERT;
    wire WEIGHT_ALERT;

    // Instantiate the Unit Under Test (UUT)
    ALERT_SYSTEM uut (
        .clk(clk), 
        .rst(rst), 
        .DOOR_STATUS(DOOR_STATUS), 
        .WEIGHT_STATUS(WEIGHT_STATUS), 
        .DOOR_ALERT(DOOR_ALERT), 
        .WEIGHT_ALERT(WEIGHT_ALERT)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        DOOR_STATUS = 0;
        WEIGHT_STATUS = 0;

        // Wait for global reset
        #100;
        
        // Test Case 1: Door opens and stays open
        DOOR_STATUS = 1;
        #200; // Wait for some time
        DOOR_STATUS = 0;
        #100;

        // Test Case 2: Weight exceeds limit
        WEIGHT_STATUS = 1;
        #100;
        WEIGHT_STATUS = 0;
        #100;

        // Test Case 3: Door opens and weight exceeds limit
        DOOR_STATUS = 1;
        WEIGHT_STATUS = 1;
        #200;
        DOOR_STATUS = 0;
        WEIGHT_STATUS = 0;
        #100;

        // Test Case 4: Door stays closed and weight is below limit
        DOOR_STATUS = 0;
        WEIGHT_STATUS = 0;
        #100;

        // Finish simulation
        $finish;
    end

    // Clock generation
    always #5 clk