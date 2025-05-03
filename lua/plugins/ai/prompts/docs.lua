return [[Please add documentation comments for the selection using the Doxygen Style Guide:

Doxygen Style Guide¶
We follow the following general guidelines when writing C++ Doxygen content:

Each line in a multiline comment begins with //! rather than block comments /**/

Insert new lines between comments and the unrelated code content above it

Use @ to prefix Doxygen commands

Since our readers are Fox-internal, create Doxygen for everything, not just public API

If you have code in anonymous namespaces, document it. It will be visible in the API docs.

@brief commands should be kept to one line if possible. More details can be included in one or more new lines below the brief.

Commands like @note, @warning, and @todo are preferred for content that goes beyond a @brief, since they “pop” visually with color-coded text boxes in the API docs.

If you ever find yourself writing “Note: <something to note>”, use a //! @note command instead.

If you ever find yourself writing “Warning: <something to beware>”, use a //! @warning command instead.

If you include a TODO comment, use //! @todo (Jira ticket #):. These will aggregrate into a TODO content page in the API docs and appear in nice color-coded text boxes.

See the blank lines and parblock section below to make your comments as readable as possible.

We also follow the specific guidelines in listed in the following sections.

@file Brief¶
If the purpose of a file is obvious (like a header file with only the eponymous class declaration), you don’t need a @file brief.

However, if you declare several classes that all fit within a theme or the file is an executable, you should have a file-level brief. //! @file appears on its own line, followed by a typical //! @brief command:


#ifndef HEADER_GUARD_
#define HEADER_GUARD_

//! @file
//! @brief Declare all the classes relevant to path primitives

#include <string>

//! @brief Path with no curvature
class StraightLine {
};

//! @brief Path with a constant curvature
class Circle {
};
class and struct Doxygen¶
@brief¶
Each class and struct declaration should get a @brief command that briefly explains its purpose, no matter how simple.

This includes nested class namespace declarations, for example:


//! @brief This is a class that does X
class DoesX {
public:
  //! @brief This struct can be helpful
  struct DoesXHelperStruct {
    //! True when this struct is helpful
    bool helpful;

    //! True when this struct is useful
    bool useful;
  };
};
Class Member Variables¶
You should include a command-less comment //! for every class member:


class DoesX {
private:
   //! This is true sometimes. False some other times.
   bool some_bool_;

   //! Could be populated with true or false. Special case if not populated.
   std::optional<bool> some_optional_bool_;
};
If the variable declaration and its comment can all fit on one line, you can use a slightly different syntax. It is not required, but can help with readability. Note how these comments line up vertically.


class DoesY {
private:
  bool has_done_y_;  //!< True if Y has been done
  int y_count_;      //!< This comment lines up with the comment above it

  //! This comment has to get its own line
  std::map<std::string, std::map<size_t, int64_t>> nested_map_of_stuff_;

  bool has_map_;       //!< Look we can use short comments again
  bool has_used_map_;  //!< True if we've used map
}
Class Functions¶
Class functions should be treated like any other function.

All the members of the class namespace can be referenced to get special font style in the API docs. For example:


class DoesX {
public:
  //! @brief Returns current x_count_ value
  int getXCount();

  //! @brief Perform X
  void doX();

private:
  //! The number of times X has been done. Increases when doX is called.
  int x_count_;
};
You might get some false positives in the API docs if you have generic function and variable names like int number().

Constructors¶
If a class constructor does not do anything interesting (e.g. call a specific parent class constructor, do interesting things with the initializer list, or do anything inside the definition scope) you don’t need to provide any comment.

But if the constructor does pretty much anything, you should give it the full function Doxygen treatment.

Spacing¶
Make sure to include new lines between Doxygen comments and the unrelated code above it. Instead of:


// Variable that means X
int variable_x;
// Variable that means Y
int variable_y;
do this instead:


//! Variable that means X
int variable_x;

//! Variable that means Y
int variable_y;
Avoid “Umbrella” Comments¶
Doxygen comments only apply to the next most immediate code. Your reader is not viewing the code itself, so the proximity of your “umbrella” comment to other code nearby no longer applies. Only the code immediately below the comment will get Doxygen content in the API docs.

Copy/pasting the full Doxygen content over and over, while effective, can be overly verbose. You can use the special @copybrief, @copydetails, or @copydoc commands instead. So instead of:


class DoesMethodABorC {
private:
   //These functions all do something similar then return true
   bool MethodA();
   bool MethodB();
   bool MethodC();

   //This function does something different
   size_t DoSomethingDifferent();
};
Do this instead:


class DoesMethodABorC {
private:
   //! @brief This function does something
   //! @return True no matter what
   bool MethodA();

   //! @copydoc MethodA
   bool MethodB();

   //! @copydoc MethodA
   bool MethodC();

   //! @brief This function does something different
   //! @return The number of times something was done
   size_t DoSomethingDifferent();
};
enum Doxygen¶
@brief¶
Each enum should get a @brief explaining its purpose.

Values¶
Each enum value should get a command-less //! or //!< comment.


//! @brief Finite set of restaurants near the office
enum class LunchOptions {
  MCDONALDS,  //!< Fast food is unhealthy but convenient
  TACO_TRUCK, //!< Only around on Tuesdays and Thursdays
};
Function Doxygen¶
@brief¶
Just like classes, try to keep these to a single line that describes the purpose of the function.

Every function should get a brief except perhaps for trivial, self-documenting ones, such as simple getter/setter functions. Even then, it’s still recommended to provide a brief.

@param[in,out]¶
Each parameter should get its own @param line.

The [in,out] part should have either [in], [out], or [in,out].

If the parameter acts purely as input and is not modified by the function, it gets an in.

If the parameter provides some input and is modified by the function, it gets an [in,out].

If the parameter’s sole purpose is to allow the function to modify it, it gets an [out].


//! @brief Determine if some number is greater than 5
//! @param[in] a The number to inspect
//! @return True if input a is above 5
bool isAbove5(const int a);

//! @brief Copy from one RobotState instance to another if any fields
//! are populated in both RobotState instances
//! @param[in] from The source RobotState
//! @param[in,out] to The destination RobotState
void copyRobotState(const RobotState& from, RobotState& to);

//! @brief Wrap a reinterpret_cast<int*> call
//! @param[out] int_ptr A void pointer to some memory address
//! @return A pointer to the memory that has interpreted it as an integer
//! @warning Maybe don't call this. It's sus. Are you writing C or something?
int* reinterpretAsInt(void* int_ptr)
@return¶
If the function returns anything other than void, it deserves an @return.

Try to cover all the possibilities explicity, especially if using return objects that could be “empty” like a std::optional or a nullptr.


//! @brief Retrieve the known forklift length if it exists.
//! @return An optional populated with the forklift length if it is known.
//! Empty optional otherwise.
std::optional<double> getForkliftLength() {
};
@note¶
If there is some extra information that goes beyond the function’s purpose, consider putting it in a @note command.


//! @brief Returns true if our deloc detector assesses that the robot is
//! currently delocalized.
//! @note There are additional conditions required to confirm deloc before
//! the robot will actually fault.
bool RobotLikelyDelocalized(float likelihood_score);
@warning¶
If there is some strict precondition for using this function, it probably deserves a @warning.


//! @brief Change RobotState to match the provided new state
//! @param[in] new_state robot_state_ will be overwritten with this content
//! @warning Not inherently thread safe. Must protect with a mutex.
void changeRobotState(const RobotState& new_state);
@throws¶
If the function can throw an exception or has some strict assert in it, it probably deserves a @throws command.


//! @brief Divide numerator by denominator and return the result
//! @return numerator divided by the denominator
//! @throws assert denominator != 0
int divideBy(const int numerator, const int denominator);
Blank Lines, parblock, and Lists¶
If you have several commands in a row of the same type, e.g. you have two //! @note sentences that should appear as two separate notes rather than one big note with two sentences, you will need to use //! @parblock to demarcate them.


//! @brief Parses command line flags.
//! @parblock
//! @note Should be called instead of directly calling
//! gflags::ParseCommandLineFlags.
//! @endparblock
//! @note Loads both per-robot flag files and flags
//! from argc/argv.
//!
//! Flags have the following precedence:
//! 1. Flags specified manually on the command line (argc/argv)
//! 2. The local flagfile: /data/config/robot/flags
//! 3. The robot-specific flagfile stored in git: config/<robot>/flags
int ParseCommandLineFlags(int* argc, char*** argv, bool remove_flags);
Warning

Every //! @parblock must have a matching //! @endparblock!

This can be a bit of a hassle to write out, but once you do it makes the API docs look great:

../../_images/parblock_doxygen_example.png
Note

The empty //! line in the example above indicates the end of the @note scope. Insert blank command-less lines like that to help with readability, but keep in mind that commands are truncated by blank command-less lines.

Lists¶
If you want a bulleted list or enumerated list, just put each bullet on its own line and it will be nicely formatted. If a bullet runs long, make sure the next line is indented to match the line above it.


//! @brief Performs work
//!
//! Does one of three things:
//! 1. Stands still
//! 2. Yells I do work over and over. It does this because it can't use an
//!    indoor voice or whisper.
//! 3. Jumps up and down
void doWork();

//! @brief Falls asleep
//!
//! Could fall asleep for several reasons:
//! - Is very tired
//! - Hasn't had any coffee today
//! - Is watching a boring movie
void sleep();
Template Params¶
Template parameters get their own special @tparam command whereever they are declared.


//! @brief Add two numbers
//! @tparam T A numeric type that supports the + operator
//! @param[in] a The first number in the sum
//! @param[in] b The second number in the sum
<typename T>
T add(const T a, const T b);
]]
