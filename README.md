# Elevator System Design
![image](https://github.com/user-attachments/assets/dc3a6757-dc8f-4beb-8002-8e3c8ae586ba)

## Project Overview
This project involves the design and implementation of a four-floor elevator system using Cadence EDA tools. The system is designed to operate at a frequency of 100MHz and includes various modules to manage the elevator's operations, ensure safety, and provide alerts in case of anomalies. The design follows a single input floor request approach, processing one floor request at a time.

## Design Specifications
- **Operating Frequency:** 100MHz
- **Number of Floors:** 4
- **Single Input Floor Request Design:** The system processes one-floor request at a time.
- **Modules Included:**
  - **Elevator_Top_Module:** The top-level module that integrates all sub-modules.
  - **alert_system:** Handles alerts and notifications for the elevator system.
  - **Controller:** Manages the control logic for the elevator operations.
- **Inputs:**
  - **weight_alert:** Signal received from a mechanical weight machine to monitor the weight inside the elevator.
  - **door_status:** Signal received from sensors to monitor the status of the elevator doors.
  - **floor_status:** Signal received from sensors to detect the current floor of the elevator.

## Module Descriptions
### Elevator_Top_Module
This is the top-level module that integrates all the sub-modules, including the alert system and controller. It processes inputs from the weight machine and sensors to control the elevator's movement and ensure safe operation.
![image](https://github.com/user-attachments/assets/7e04a4ef-9f1f-4c29-a114-3c0aacb04f43)
### alert_system
The alert system module is responsible for handling alerts and notifications. It monitors the weight inside the elevator and the status of the doors and floors. If any anomalies or emergencies are detected, it triggers appropriate alerts to notify the users and maintenance personnel.

### controller
The controller module manages the control logic for the elevator operations. It processes the inputs from the weight machine and sensors to determine the elevator's movement. The controller ensures that the elevator operates smoothly and safely, coordinating the opening and closing of doors and the movement between floors.

## Additional Specifications
- **Elevator Controller:** Handles requests to move between three floors.
- **Door Alert:** Activates if the door remains open for more than 3 minutes.
- **Weight Alert:** Activates if the weight status is greater than 4500lbs.
- **Movement Logic:** The elevator decides its moving direction based on the requested floor and uses sensors to detect floor levels. It gives an output `complete = 1` when it reaches the requested floor. The direction output is high when moving upwards and low when moving downwards.


## Dependencies
- **alert_system.v:** Verilog file for the alert system module.
- **controller.v:** Verilog file for the controller module.

## Additional Comments
- Ensure all modules are properly instantiated and connected within the top module.
- Verify the timing and synchronization between the controller and alert system.
- Conduct thorough testing to ensure the system operates as expected under various scenarios.

## Getting Started
To get started with the project, follow these steps:
1. Clone the repository to your local machine.
2. Open the project in your preferred Verilog development environment.
3. Review the module files and ensure all dependencies are included.
4. Compile and simulate the design to verify its functionality.


## Contributing
If you would like to contribute to this project, please fork the repository and submit a pull request with your changes. Ensure that your code follows the project's coding standards and includes appropriate documentation.

## Contact
For any questions or inquiries, please contact Ankit kumar at ankitkumar.work121@gmail.com.
