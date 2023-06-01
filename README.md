# Swift Code Generation (proof of concept)
The code generator outputs <a href="https://www.swift.org/documentation/api-design-guidelines/">API Design Guidelines</a> based Swift source code from Substrate framework runtime metadata. The aim of this library is two-fold. One, it aims to ease the mental burden of learning the Substrate framework as a Swift developer. Two, it aims to support maintainability through clarity and testability, such that:

* Runtime upgrade changes are easy to identify. Source code output is verified through Substrate runtime-specific unit test suites. 
* Ad hoc changes are easy to make. The modularity of FRAME is preserved in the Swift language source code.
* The output is coupled to the metadata rather than the project maintainer. Client APIs can be generated for custom pallets with minimal additional effort.

This is a naive proof of concept based on the factory design pattern and will be deprecated.

**Disclaimer** This is proof of concept code used to think about high level solution design. It may contain incomplete thoughts. The code should not be used as is.
