#!/bin/bash

# Define the directory to store records
RECORDS_DIR="NEW_RECORDS"

# Ensure the records directory exists; create it if it doesn't
mkdir -p "$RECORDS_DIR"

# Display menu
display_menu() {
    clear
    echo "What is the mission today?"
    echo "1. Add new record"
    echo "2. Edit record"
    echo "3. Search record"
    echo "4. Generate report"
    echo "5. Generate password"
    echo "6. Run backup"
    echo "7. Exit menu"
    echo "Make a choice:  "
}


# Function to add a new record
add_record() {
    clear
    echo "NEW RECORD"
    echo "----------"

    read -p "Enter record name: " new_record
    read -p "Description: " content
    touch "$RECORDS_DIR/$new_record"

    echo "$new_record:$content" >> "$RECORDS_DIR/$new_record"

    echo "New record added successfully"
    read -n 1 -s -r -p "Press any key to continue"
}

# Function to edit an existing record
edit_record() {
    clear
    echo "Edit record"
    echo "------------"
    read -p "Enter the file name you'd like to edit: " new_record

    # Search for the record in the directory
    grep -i "$new_record" "$RECORDS_DIR/$new_record" > file.txt

    if [ -s "file.txt" ]; then
        echo "Record found"
        cat "file.txt"

        read -p "Update record: " update

        # Replace old record with update
        sed -i "s/$new_record:*/$new_record:$update/" "$RECORDS_DIR/$new_record"
        echo "Record updated successfully"
        read -n 1 -s -r -p "Press any key to continue"
    else
        echo "Record not found"
        read -n 1 -s -r -p "Press any key to continue"
    fi

    rm "file.txt"
}

# Function to search for a record
search_record() {
    clear
    echo "Search contact"
    echo "---------------"

    read -p "Enter record name to search: " new_record

    # Search for the record in the directory
    grep -i "$new_record" "$RECORDS_DIR/$new_record"

    read -n 1 -s -r -p "Press any key to continue"
}

# Function to generate report
generate_report() {
    clear
    echo "Generate report"
    echo "---------------"

    echo "Records"
    ls "$RECORDS_DIR"

    read -n 1 -s -r -p "Press any key to continue"
}

# Function to generate a random password
generate_password() {
    clear
    echo "Please enter the length of the password:"

    read -r PASS_LENGTH
    sleep 1

    echo "Generating possible passwords..."

    for p in $(seq 1 10); do
        openssl rand -base64 48 | head -c "$PASS_LENGTH"
        echo
    done

    read -n 1 -s -r -p "Press any key to continue"
}

run_backup() {
   echo "Wait a second...."
   sleep 1

   SOURCE_DIR="Personal_Record_System"
   DEST_DIR="Downloads"
   rsync -av "$SOURCE_DIR" "$DEST_DIR"
}


# Main menu loop
while true; do
    display_menu
    read -r choice

    case $choice in
    1) add_record ;;
    2) edit_record ;;
    3) search_record ;;
    4) generate_report ;;
    5) generate_password ;;
    6) run_backup ;;
    7)
        echo "Exiting..."
        exit ;;
    esac
done

