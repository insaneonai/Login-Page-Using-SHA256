#include <iostream>
#include <openssl/sha.h>
#include <iomanip>
#include <limits>
#include <sstream>
#include <vector>
#include <fstream>

using namespace std;

// Function to compute SHA-256 hash
string sha256(const string& str) {
    unsigned char hash[SHA256_DIGEST_LENGTH];
    SHA256(reinterpret_cast<const unsigned char*>(str.c_str()), str.size(), hash);

    stringstream ss;
    for (int i = 0; i < SHA256_DIGEST_LENGTH; ++i) {
        ss << hex << setw(2) << setfill('0') << static_cast<int>(hash[i]);
    }
    return ss.str();
}

// Class representing student information
class StudentInfo {
public:
    string name;
    string rollno;
    string hash;

    StudentInfo() {}

    StudentInfo(string& nam, string& rollo, string& password) {
        name = nam;
        rollno = rollo;
        hash = sha256(password);
    }

    bool checkPassword(const string& pass) const {
        return hash == sha256(pass);
    }
};

int main() {
    int c=0; vector<StudentInfo> stu_vec;
    ifstream file("studentdb.bin", ios::in | ios::binary);
    if (file.good()) {
        StudentInfo stud;
        while (file.read(reinterpret_cast<char*>(&stud), sizeof(stud))) {
            stu_vec.push_back(stud);
        }
    }
    file.close();

    fstream filer("studentdb.bin", ios::app | ios::binary);

    cout << c;
    while (c!=3) {
        if (c == 0) {
            cout << "MENU" << endl;
            cout << "1. Sign Up" << endl;
            cout << "2. Login" << endl;
            cout << "3. Exit" << endl;
            cout << "Enter your choice: ";
            cin >> c;
        }
        else if (c == 1) {
            string name, rollno, password;
            char l;
            cout << endl;
            cout << "Signup Form" << endl;
            cout << "Please enter Name: ";
            cin >> name;
            cout << endl;
            cout << "Please enter rollno: ";
            cin >> rollno;
            cout << endl;
            cout << "Please enter password: ";
            cin >> password;
            cout << endl;
            StudentInfo student(name, rollno, password);
            stu_vec.push_back(student);
            filer.write(reinterpret_cast<char*>(&student), sizeof(student));
            cout << "Signup done successfully." << endl;
            cout << "Do you want to login?: Y/N";
            cin >> l;
            c = (l == 'Y') ? 2 : 0;
        }
        else if (c == 2) {
            string name, password;
            cout << endl;
            cout << "Login Form" << endl;
            cout << "Please enter Name: ";
            cin >> name;
            cout << endl;
            cout << "Please enter password: ";
            cin >> password;
            cout << endl;
            bool found = false;
            for (auto& student : stu_vec) {
                if (student.name == name) {
                    found = true;
                    if (student.hash == sha256(password)) {
                        cout << "Login Success! Displaying details" << endl;
                        cout << "Name: " << student.name << endl << "Rollno: " << student.rollno << endl << "Hash: " << student.hash << endl;
                    }
                    else {
                        cout << "Invalid credentials";
                    }
                }
            }
            if (!found) {
                cout << "User doesn't Exist!";
            }
            c = 0;
        
        }
        else if (c == 3) {
            break;
        }
        else {
            cout << "Invalid Input...." << endl;
        }
    }



    return 0;
}
