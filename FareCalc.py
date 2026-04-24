import sys

# Dictionary Mapping (now using vehicle names)
rates = {
    "economy": ("Economy", 10),
    "premium": ("Premium", 18),
    "suv": ("SUV", 25)
}

# Function to calculate fare (with error handling)
def calculate_fare(km, vehicle_type, hour):
    try:
        vehicle_name, rate = rates[vehicle_type]
    except KeyError:
        return None

    total = km * rate

    # Surge pricing
    if 17 <= hour <= 20:
        surge = 1.5
    else:
        surge = 1.0

    final_price = total * surge
    return vehicle_name, rate, final_price, surge


# Main program
print("CityCab Fare Calculator")

# Distance input
while True:
    user_input = input("Enter distance (in km): ")

    if user_input.lower() == 'q':
        print("Exiting")
        sys.exit()

    try:
        km = float(user_input)
        if km <= 0:
            print("Invalid distance. Please enter a value greater than 0.")
        else:
            break
    except:
        print("Invalid input. Please enter numbers only.")

# Vehicle input (fixed)
while True:
    user_input = input("Enter vehicle type (Economy / Premium / SUV): ").strip()

    if user_input.lower() == 'q':
        print("Exiting")
        sys.exit()

    vehicle_type = user_input.lower()
    break   # allow any input, function will validate

# Hour input
while True:
    user_input = input("Enter hour of travel (0-23): ")

    if user_input.lower() == 'q':
        print("Exiting")
        sys.exit()

    try:
        hour = int(user_input)
        if 0 <= hour <= 23:
            break
        else:
            print("Hour must be between 0 and 23.")
    except:
        print("Invalid input. Please enter a valid number.")

# Calculate fare
result = calculate_fare(km, vehicle_type, hour)

# Output
if result is None:
    print("\nService Not Available")
else:
    vehicle_name, rate, final_price, surge = result

    print("\nRide Estimate Receipt")
    print("Distance:", km, "km")
    print("Vehicle Type:", vehicle_name)
    print("Rate per km:", rate)
    print("Travel Hour:", hour)
    print("Total Fare: Rs.", round(final_price, 2))
    print("Thank you for using CityCab")