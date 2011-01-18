%module casadi

#ifdef WITH_DOXDOC
%include "../doc/doc.i"
#endif 

#ifndef WITH_DOXDOC
#warning "Not using doxygen. Run /doc/doc2swig.py to include it. A make rebuild-cache may be necessary."
#endif

%feature("autodoc", "1");

// STL
%include "std_string.i"
%include "std_vector.i"

// Move to C++
#ifndef SWIG
namespace CasADi{
  typedef std::vector<bool> BVector;
  typedef std::vector<std::vector<bool> > BVectorVector;
  typedef std::vector< std::vector<std::vector<bool> > > BVectorVectorVector;
  
  typedef std::vector<int> IVector;
  typedef std::vector<std::vector<int> > IVectorVector;
  typedef std::vector< std::vector<std::vector<int> > > IVectorVectorVector;
  
  typedef std::vector<double> DVector;
  typedef std::vector<std::vector<double> > DVectorVector;
  typedef std::vector< std::vector<std::vector<double> > > DVectorVectorVector;
} // namespace CasADi
#else // SWIG
%template(BVector)             std::vector<bool>;
%template(BVectorVector)       std::vector<std::vector<bool> > ;
%template(BVectorVectorVector) std::vector< std::vector<std::vector<bool> > > ;

%template(IVector)             std::vector<int>;
%template(IVectorVector)       std::vector<std::vector<int> > ;
%template(IVectorVectorVector) std::vector< std::vector<std::vector<int> > > ;

%template(DVector)             std::vector<double>;
%template(DVectorVector)       std::vector<std::vector<double> > ;
%template(DVectorVectorVector) std::vector< std::vector<std::vector<double> > > ;

#endif // SWIG

#ifndef WITH_NUMPY
#warning "Not using numpy. option(WITH_NUMPY = OFF)"
#endif

#ifdef WITH_NUMPY
#warning "Using numpy. option(WITH_NUMPY = ON)"
%include "numpy.i"
#endif

// Auxilliary casadi functions
%include "casadi_aux.i"

// SX class
%include "sx.i"

// MX class
%include "mx.i"

// FX
%include "fx.i"

// Matrix tools
%include "casadi/matrix/matrix_tools.hpp"

// Instansiate the functions
MATRIX_TOOLS_TEMPLATES(double)
MATRIX_TOOLS_TEMPLATES(CasADi::SX)

// SX tools
%include "casadi/sx/sx_tools.hpp"

// IPOPT
#ifdef WITH_IPOPT
%include "ipopt_interface.i"
#endif

// Modelica
#ifdef WITH_MODELICA
%include "modelica.i"
#endif

// ACADO
#ifdef WITH_ACADO
%include "acado_interface.i"
#endif

// Sundials
#ifdef WITH_SUNDIALS
%include "sundials_interface.i"
#endif

// SuperLU
#ifdef WITH_SUPERLU
%include "superlu.i"
#endif

// LAPACK
#ifdef WITH_LAPACK
%include "lapack_interface.i"
#endif

%extend std::vector<double>{
  std::string __repr__(){
    char buffer[32];
    std::string ret;
    ret += "[";
    for(int i=0; i<$self->size(); ++i){
      if(i!=0)
        ret += ",";
      
      // Print to buffer
      snprintf(buffer, 32, "%g", $self->at(i));
      
      // Append to string
      ret += buffer;
      
      if(i==0){
        // We can now estimate the total size of the string
        ret.reserve(ret.size()*$self->size() + 10);
      }
      
    }
    ret += "]";
    return ret;
  }

  std::string __str__(){
    char buffer[32];
    std::string ret;
    
    // Add dimensions
    snprintf(buffer, 32, "[%d]", $self->size());
    ret += buffer;
    
    ret += "(";
    for(int i=0; i<$self->size(); ++i){
      if(i!=0)
        ret += ",";
      
      // Print to buffer
      snprintf(buffer, 32, "%g", $self->at(i));
      
      // Append to string
      ret += buffer;
      
      if(i==0){
        // We can now estimate the total size of the string
        ret.reserve(ret.size()*$self->size() + 10);
      }
      
    }
    ret += ")";
    return ret;
  }
};

