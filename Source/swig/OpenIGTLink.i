%module OpenIGTLink
%include <windows.i>
%include "std_string.i"
%include "carrays.i"

%array_class(float, floatArray);
%array_class(char, charArray);
%array_class(int, intArray);

%inline %{
  void setImageMessageData(void* scalarPointer, int* pixel_array, int size){
    //scalarPointer = (unsigned char*) pixel_array;

	//unsigned char* temp_array = (unsigned char*) pixel_array;
	//printf("%d \n", sizeof(temp_array));
	//printf("%d \n", sizeof(pixel_array));

	unsigned char* temp_array = new unsigned char[size]();

	for(int i = 0; i<size; i++){
	  temp_array[i] = (unsigned char) pixel_array[i];
	}	

	FILE *fw = fopen("C:/w/temp.bin", "wb");
	fwrite(temp_array, 1, size, fw);
	fclose(fw);

	FILE *fp = fopen("C:/w/temp.bin", "rb");
	size_t b = fread(scalarPointer, 1, size, fp);
	fclose(fp);

	delete[] temp_array;

	//for(int i = 0; i<size; i++){
	  //printf("%d ", pixel_array[i]);
	//}

  }
%}

%begin %{
#ifdef _MSC_VER
#define SWIG_PYTHON_INTERPRETER_NO_DEBUG
#endif
%}


#define IGTLCommon_EXPORT __declspec(dllexport)
#define igtl_export __declspec(dllexport)

#define igtlNewMacro(x) \
static Pointer New(void) \
{ \
  Pointer smartPtr = ::igtl::ObjectFactory<x>::Create(); \
  if(smartPtr.GetPointer() == NULL) \
    { \
    smartPtr = new x; \
    } \
  smartPtr->UnRegister(); \
  return smartPtr; \
} \
virtual ::igtl::LightObject::Pointer CreateAnother(void) const \
{ \
  return x::New().GetPointer(); \
} \

#define igtlTypeMacro(thisClass,superclass) \
    virtual const char *GetNameOfClass() const \
        {return #thisClass;}

        
%{
#define SWIG_FILE_WITH_INIT

#pragma comment(lib, "Ws2_32.lib")

//#include "igtlMacro.h"
//#include "igtlWin32Header.h"

typedef float Matrix4x4[4][4];
typedef float igtlFloat32;

#include "igtlSocket.h"
#include <windows.h>
#include <winsock2.h> 
#include <iostream>
#include "igtlMath.h"
#include "igtlSimpleFastMutexLock.h"
#include "igtlSmartPointer.h"
#include "igtlObject.h"
#include "igtlLightObject.h"
#include "igtlMessageBase.h"
#include "igtlMessageHeader.h"
#include "igtlMessageFactory.h"

#include "igtlSocket.h"
#include "igtlServerSocket.h"
#include "igtlClientSocket.h"
#include "igtlTransformMessage.h"
#include "igtlStringMessage.h"
//#include "igtlStatusMessage.h"
#include "igtlPointMessage.h"
#include "igtlImageMessage.h"
//#include "igtlImageMessage2.h"
//#include "igtlPolyDataMessage.h"
//#include "igtlPositionMessage.h"

//#include "igtlBindMessage.h"
//#include "igtlTrajectoryMessage.h"
//#include "igtlSensorMessage.h"
//#include "igtlQueryMessage.h"
//#include "igtlNDArrayMessage.h"
//#include "igtlTrackingDataMessage.h"
//#include "igtlQuaternionTrackingDataMessage.h"
//#include "igtlLabelMetaMessage.h"
//#include "igtlImageMetaMessage.h"
//#include "igtlCapabilityMessage.h"
//#include "igtlColorTableMessage.h"
//#include "igtlCommandMessage.h"
%}

//%feature("smartptr");

//%template(SmartPointerObject) SmartPointer<igtl::Object>;
//%template(SmartPointerSocket) SmartPointer<Socket>;
%import "igtlSmartPointer.h"
%import "igtlLightObject.h"
%import "igtlObject.h"

// Classes to be wrapped:
%include "igtlSocket.h"
%include "igtlMath.h"
%include "igtlServerSocket.h"
%include "igtlClientSocket.h"
%include "igtlMessageBase.h"
%include "igtlTransformMessage.h"
%include "igtlStringMessage.h"
%include "igtlPointMessage.h"
%include "igtlImageMessage.h"
//%include "igtlImageMessage2.h"
%include "igtlMessageHeader.h"

//%include "igtlStatusMessage.h"
//%include "igtlPolyDataMessage.h"
//%include "igtlPositionMessage.h"

//%include "igtlBindMessage.h"
//%include "igtlTrajectoryMessage.h"
////%include "igtlSensorMessage.h"
////%include "igtlQueryMessage.h"
//%include "igtlNDArrayMessage.h"
//%include "igtlTrackingDataMessage.h"
//%include "igtlQuaternionTrackingDataMessage.h"
//%include "igtlLabelMetaMessage.h"
//%include "igtlImageMetaMessage.h"
//%include "igtlCapabilityMessage.h"
//%include "igtlColorTableMessage.h"
//%include "igtlCommandMessage.h"
