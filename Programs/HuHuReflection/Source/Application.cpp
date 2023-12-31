#include <iostream>
#include <fstream>
#include "boost/program_options.hpp"
#include "boost/filesystem.hpp"

namespace bpo = boost::program_options;

std::string BasePath;
std::string IntermediatePath;

int main(int argc, const char** argv) {

    bpo::options_description Desc("Allowed options");
    Desc.add_options()
        ("help", "show help message")
        ("generate", "generate reflection data")
        ("path", bpo::value<std::string>(&BasePath)->default_value("."), "root path of the project")
        ("intermediate", bpo::value<std::string>(&IntermediatePath)->default_value("build/.refl"), "path to store intermediate data")
    ;

    bpo::variables_map Variables;
    bpo::store(bpo::parse_command_line(argc, argv, Desc), Variables);
    bpo::notify(Variables);

    if (Variables.empty() || Variables.count("help") ) {
        std::cout << Desc << std::endl;
        return 0;
    }

    if (Variables.count("generate")) {
        std::cout << "generating reflection data..." << std::endl;

        boost::filesystem::path IntermediatePathSys(IntermediatePath);
        if (boost::filesystem::create_directories(IntermediatePathSys)) {
            std::cout << "created directory: " << absolute(IntermediatePathSys) << std::endl;
        }

        std::ofstream OutFile(IntermediatePath + "/ReflectionData.cpp");
        if (OutFile.is_open()) {
            OutFile.seekp(0);
            OutFile << "// This file is generated by HuHuReflection" << std::endl;
            OutFile << "#include \"SystemRegistry.h\"" << std::endl;
            OutFile << "#include <iostream>" << std::endl;
            OutFile << "namespace reflection {" << std::endl;
            OutFile << "void GetRegistry() { std::cout << \"123\" << std::endl;  }" << std::endl;
            OutFile << "}" << std::endl;
        }

        std::cout << "Scanning directory < " << BasePath << " >" << std::endl;
        boost::filesystem::recursive_directory_iterator DirectoryIter(BasePath);

        return 0;
    }

    return 0;
}
