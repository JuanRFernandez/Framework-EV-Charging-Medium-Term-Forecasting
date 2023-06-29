import sys

REQUIRED_PYTHON = "python3"


def main():
    system_major = sys.version_info.major
    system_minor = sys.version_info.minor
    if REQUIRED_PYTHON == "python":
        required_major = 2
    elif REQUIRED_PYTHON == "python3":
        required_major = 3
    else:
        raise ValueError("Unrecognized python interpreter: {}".format(
            REQUIRED_PYTHON))

    # Here we check if the required major version matches the system's major version
    if system_major != required_major:
        raise TypeError(
            "This project requires Python {}. Found: Python {}".format(
                required_major, sys.version))
    
    # And here we could add additional checks for the minor version, for example
    if system_major == 3 and system_minor < 7:
        raise TypeError(
            "This project requires Python 3.7 or higher. Found: Python {}".format(sys.version))

    print(">>> Development environment passes all tests!")

