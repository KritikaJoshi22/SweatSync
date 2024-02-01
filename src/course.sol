// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

contract CoursesMarketplace is Ownable {

    struct Course {
        uint256 id;
        string title;
        string description;
        address payable instructor;
        uint256 price;
        bool isAvailable;
        mapping(address => bool) enrolledStudents;
    }

    mapping(uint256 => Course) public courses;
    uint256 public courseCount;

    event CourseCreated(uint256 id, string title, address instructor, uint256 price);
    event CourseEnrolled(uint256 id, address student);

    constructor()Ownable(msg.sender) {
    }

    function createCourse(string memory _title, string memory _description, uint256 _price) public onlyOwner {
        courseCount++;
        Course storage newCourse = courses[courseCount];
        newCourse.id = courseCount;
        newCourse.title = _title;
        newCourse.description = _description;
        newCourse.instructor = payable(msg.sender);
        newCourse.price = _price;
        newCourse.isAvailable = true;
        emit CourseCreated(courseCount, _title, msg.sender, _price);
    }



    function enroll(address _user, uint256 _courseId) public payable {
        require(_courseId > 0 && _courseId <= courseCount, "Invalid course ID");
        Course storage course = courses[_courseId];
        require(course.isAvailable, "Course is not available");
        require(!course.enrolledStudents[_user], "Already enrolled");

        require(msg.value == course.price, "Incorrect amount sent");

        course.instructor.transfer(msg.value);
        course.enrolledStudents[msg.sender] = true;

        emit CourseEnrolled(_courseId, msg.sender);
    }

    function getCourse(uint256 _courseId) public view returns (uint256 id, string memory title, string memory description, address instructor, uint256 price, bool isAvailable) {
        Course storage course = courses[_courseId];
        return (course.id, course.title, course.description, course.instructor, course.price, course.isAvailable);
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        payable(_owner).transfer(address(this).balance);
    }
}