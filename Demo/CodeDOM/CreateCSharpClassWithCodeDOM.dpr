program CreateCSharpClassWithCodeDOM;

{$WARN SYMBOL_PLATFORM OFF}
{$APPTYPE CONSOLE}
{$R *.res}

uses
  CNClrLib.Enums,
  CNClrLib.EnumTypes,
  CNClrLib.CodeDom,
  CNClrLib.CSharp,
  CNClrLib.Core,
  CNClrLib.Host;

const
  /// <summary>
  /// The name of the file to contain the source code.
  /// </summary>
  outputFileName = 'SampleCode.cs';

var
  /// <summary>
  /// Define the compile unit to use for code generation.
  /// </summary>
  targetUnit: _CodeCompileUnit;

  /// <summary>
  /// The only class in the compile unit. This class contains 2 fields,
  /// 3 properties, a constructor, an entry point, and 1 simple method.
  /// </summary>
  targetClass: _CodeTypeDeclaration;

type
  /// <summary>
  /// This code example creates a graph using a CodeCompileUnit and
  /// generates source code for the graph using the CSharpCodeProvider.
  /// </summary>
  TSample = class
  public
    constructor Create;

    procedure AddFields;
    procedure AddProperties;
    procedure AddMethod;
    procedure AddConstructor;
    procedure AddEntryPoint;
    procedure GenerateCSharpCode(fileName: string);
  end;

  /// <summary>
  /// Define the class.
  /// </summary>
  constructor TSample.Create;
  var
    samples: _CodeNamespace;
  begin
    targetUnit := CoCodeCompileUnit.CreateInstance;
    samples := CoCodeNamespace.CreateInstance('CodeDOMSample');
    samples.Imports.Add(CoCodeNamespaceImport.CreateInstance('System'));
    targetClass := CoCodeTypeDeclaration.CreateInstance('CodeDOMCreatedClass');
    targetClass.IsClass := true;
    targetClass.TypeAttributes := TypeAttributes_Public or TypeAttributes_Sealed;
    samples.Types.Add(targetClass);
    targetUnit.Namespaces.Add(samples);
  end;

  /// <summary>
  /// Adds two fields to the class.
  /// </summary>
  procedure TSample.AddFields;
  var
    widthValueField: _CodeMemberField;
    heightValueField: _CodeMemberField;
  begin
    // Declare the widthValue field.
    widthValueField := CoCodeMemberField.CreateInstance;
    widthValueField.Attributes := MemberAttributes_Private;
    widthValueField.Name := 'widthValue';
    widthValueField.Type_ := CoCodeTypeReference.CreateInstance(TClrAssembly.GetType('System.Double'));
    widthValueField.Comments.Add(CoCodeCommentStatement.CreateInstance('The width of the object.'));
    targetClass.Members.Add(widthValueField.AsCodeTypeMember);

    // Declare the heightValue field
    heightValueField := CoCodeMemberField.CreateInstance;
    heightValueField.Attributes := MemberAttributes_Private;
    heightValueField.Name := 'heightValue';
    heightValueField.Type_ := CoCodeTypeReference.CreateInstance(TClrAssembly.GetType('System.Double'));
    heightValueField.Comments.Add(CoCodeCommentStatement.CreateInstance('The height of the object.'));
    targetClass.Members.Add(heightValueField.AsCodeTypeMember);
  end;

  /// <summary>
  /// Add three properties to the class.
  /// </summary>
  procedure TSample.AddProperties;
  var
    widthProperty: _CodeMemberProperty;
    heightProperty: _CodeMemberProperty;
    areaProperty: _CodeMemberProperty;
    areaExpression: _CodeBinaryOperatorExpression;
  begin
    // Declare the read-only Width property.
    widthProperty := CoCodeMemberProperty.CreateInstance;
    widthProperty.Attributes := MemberAttributes_Public or MemberAttributes_Final;
    widthProperty.Name := 'Width';
    widthProperty.HasGet := true;
    widthProperty.Type_ := CoCodeTypeReference.CreateInstance(TClrAssembly.GetType('System.Double'));
    widthProperty.Comments.Add(CoCodeCommentStatement.CreateInstance('The Width property for the object.'));
    widthProperty.GetStatements.Add(CoCodeMethodReturnStatement.CreateInstance(
        CoCodeFieldReferenceExpression.CreateInstance(
          CoCodeThisReferenceExpression.CreateInstance.AsCodeExpression,
          'widthValue').AsCodeExpression).AsCodeStatement);
    targetClass.Members.Add(widthProperty.AsCodeTypeMember);

    // Declare the read-only Height property.
    heightProperty := CoCodeMemberProperty.CreateInstance;
    heightProperty.Attributes := MemberAttributes_Public or MemberAttributes_Final;
    heightProperty.Name := 'Height';
    heightProperty.HasGet := true;
    heightProperty.Type_ := CoCodeTypeReference.CreateInstance(TClrAssembly.GetType('System.Double'));
    heightProperty.Comments.Add(CoCodeCommentStatement.CreateInstance('The Height property for the object.'));
    heightProperty.GetStatements.Add(CoCodeMethodReturnStatement.CreateInstance(
        CoCodeFieldReferenceExpression.CreateInstance(
          CoCodeThisReferenceExpression.CreateInstance.AsCodeExpression,
          'heightValue').AsCodeExpression).AsCodeStatement);
    targetClass.Members.Add(heightProperty.AsCodeTypeMember);

    // Declare the read only Area property.
    areaProperty := CoCodeMemberProperty.CreateInstance;
    areaProperty.Attributes := MemberAttributes_Public or MemberAttributes_Final;
    areaProperty.Name := 'Area';
    areaProperty.HasGet := true;
    areaProperty.Type_ := CoCodeTypeReference.CreateInstance(TClrAssembly.GetType('System.Double'));
    areaProperty.Comments.Add(CoCodeCommentStatement.CreateInstance('The Area property for the object.'));

    // Create an expression to calculate the area for the get accessor
    // of the Area property.
    areaExpression := CoCodeBinaryOperatorExpression.CreateInstance(
        CoCodeFieldReferenceExpression.CreateInstance(
          CoCodeThisReferenceExpression.CreateInstance.AsCodeExpression, 'widthValue').AsCodeExpression,
        cbotMultiply,
        CoCodeFieldReferenceExpression.CreateInstance(
          CoCodeThisReferenceExpression.CreateInstance.AsCodeExpression, 'heightValue').AsCodeExpression);
    areaProperty.GetStatements.Add(
        CoCodeMethodReturnStatement.CreateInstance(areaExpression.AsCodeExpression).AsCodeStatement);
    targetClass.Members.Add(areaProperty.AsCodeTypeMember);
  end;

  /// <summary>
  /// Adds a method to the class. This method multiplies values stored
  /// in both fields.
  /// </summary>
  procedure TSample.AddMethod;
  var
    toStringMethod: _CodeMemberMethod;
    widthReference: _CodeFieldReferenceExpression;
    heightReference: _CodeFieldReferenceExpression;
    areaReference: _CodeFieldReferenceExpression;
    returnStatement: _CodeMethodReturnStatement;
    formattedOutput: string;
    Environment: _Environment;
    Parameters: _CodeExpressionArray;
  begin
    // Declaring a ToString method
    toStringMethod := CoCodeMemberMethod.CreateInstance;
    toStringMethod.Attributes := MemberAttributes_Public or MemberAttributes_Override;
    toStringMethod.Name := 'ToString';
    toStringMethod.ReturnType := CoCodeTypeReference.CreateInstance(TClrAssembly.GetType('System.String'));

    widthReference := CoCodeFieldReferenceExpression.CreateInstance(
        CoCodeThisReferenceExpression.CreateInstance.AsCodeExpression, 'Width');
    heightReference := CoCodeFieldReferenceExpression.CreateInstance(
        CoCodeThisReferenceExpression.CreateInstance.AsCodeExpression, 'Height');
    areaReference := CoCodeFieldReferenceExpression.CreateInstance(
        CoCodeThisReferenceExpression.CreateInstance.AsCodeExpression, 'Area');

    // Declaring a return statement for method ToString.
    returnStatement := CoCodeMethodReturnStatement.CreateInstance;

    Environment := CoEnvironment.CreateInstance;
    // This statement returns a string representation of the width,
    // height, and area.
    formattedOutput := 'The object:' + Environment.NewLine +
        ' width = {0},' + Environment.NewLine +
        ' height = {1},' + Environment.NewLine +
        ' area = {2}';

    Parameters := CoCodeExpressionArray.CreateInstance(4);
    Parameters[0] := CoCodePrimitiveExpression.CreateInstance(formattedOutput).AsCodeExpression;
    Parameters[1] := widthReference.AsCodeExpression;
    Parameters[2] := heightReference.AsCodeExpression;
    Parameters[3] := areaReference.AsCodeExpression;

    returnStatement.Expression :=
        CoCodeMethodInvokeExpression.CreateInstance(
          CoCodeTypeReferenceExpression.CreateInstance('System.String').AsCodeExpression,
          'Format', Parameters).AsCodeExpression;

    toStringMethod.Statements.Add(returnStatement.AsCodeStatement);
    targetClass.Members.Add(toStringMethod.AsCodeTypeMember);
  end;

  /// <summary>
  /// Add a constructor to the class.
  /// </summary>
  procedure TSample.AddConstructor;
  var
    constructorA: _CodeConstructor;
    widthReference: _CodeFieldReferenceExpression;
    heightReference: _CodeFieldReferenceExpression;
  begin
    // Declare the constructor
    constructorA := CoCodeConstructor.CreateInstance;
    constructorA.Attributes := MemberAttributes_Public or MemberAttributes_Final;

    // Add parameters.
    constructorA.Parameters.Add(
        CoCodeParameterDeclarationExpression.CreateInstance(
          TClrAssembly.GetType(tcDouble),
          'width'));
    constructorA.Parameters.Add(
        CoCodeParameterDeclarationExpression.CreateInstance(
          TClrAssembly.GetType(tcDouble),
          'height'));

    // Add field initialization logic
     widthReference :=
        CoCodeFieldReferenceExpression.CreateInstance(
          CoCodeThisReferenceExpression.CreateInstance.AsCodeExpression, 'widthValue');
    constructorA.Statements.Add(CoCodeAssignStatement.CreateInstance(widthReference.AsCodeExpression,
        CoCodeArgumentReferenceExpression.CreateInstance('width').AsCodeExpression).AsCodeStatement);

     heightReference := CoCodeFieldReferenceExpression.CreateInstance(
        CoCodeThisReferenceExpression.CreateInstance.AsCodeExpression, 'heightValue');
    constructorA.Statements.Add(CoCodeAssignStatement.CreateInstance(heightReference.AsCodeExpression,
        CoCodeArgumentReferenceExpression.CreateInstance('height').AsCodeExpression).AsCodeStatement);

    targetClass.Members.Add(constructorA.AsCodeMemberMethod.AsCodeTypeMember);
  end;

  /// <summary>
  /// Add an entry point to the class.
  /// </summary>
  procedure TSample.AddEntryPoint;
  var
    start: _CodeEntryPointMethod;
    objectCreate: _CodeObjectCreateExpression;
    Parameters: _CodeExpressionArray;
    toStringInvoke: _CodeMethodInvokeExpression;
  begin
    start := CoCodeEntryPointMethod.CreateInstance;
    Parameters:= CoCodeExpressionArray.CreateInstance(2);
    Parameters[0] := CoCodePrimitiveExpression.CreateInstance(5.3).AsCodeExpression;
    Parameters[1] := CoCodePrimitiveExpression.CreateInstance(6.9).AsCodeExpression;
    objectCreate := CoCodeObjectCreateExpression.CreateInstance(
      CoCodeTypeReference.CreateInstance('CodeDOMCreatedClass'),
      Parameters);

    // Add the statement:
    // "CodeDOMCreatedClass testClass =
    //     new CodeDOMCreatedClass(5.3, 6.9);"
    start.Statements.Add(CoCodeVariableDeclarationStatement.CreateInstance(
          CoCodeTypeReference.CreateInstance('CodeDOMCreatedClass'),
          'testClass',
          objectCreate.AsCodeExpression).AsCodeStatement);

    // Creat the expression:
    // "testClass.ToString()"
     toStringInvoke := CoCodeMethodInvokeExpression.CreateInstance(
                        CoCodeVariableReferenceExpression.CreateInstance('testClass').AsCodeExpression,
                        'ToString', CoCodeExpressionArray.CreateInstance(0));

    // Add a System.Console.WriteLine statement with the previous
    // expression as a parameter.
    Parameters:= CoCodeExpressionArray.CreateInstance(1);
    Parameters[0] := toStringInvoke.AsCodeExpression;

    start.Statements.Add_1(
          CoCodeMethodInvokeExpression.CreateInstance(
          CoCodeTypeReferenceExpression.CreateInstance('System.Console').AsCodeExpression,
          'WriteLine', Parameters).AsCodeExpression);

    targetClass.Members.Add(start.AsCodeMemberMethod.AsCodeTypeMember);
  end;

  /// <summary>
  /// Generate CSharp source code from the compile unit.
  /// </summary>
  /// <param name="filename">Output file name</param>
  procedure TSample.GenerateCSharpCode(fileName: string);
  var
    provider: _CodeDomProvider;
    providerHelper: _CodeDomProviderHelper;
    options: _CodeGeneratorOptions;
    sourceWriter: _StreamWriter;
  begin
    providerHelper := CoCodeDomProviderHelper.CreateInstance;
    provider := providerHelper.CreateProvider_1('CSharp');
    options := CoCodeGeneratorOptions.CreateInstance;
    options.BracingStyle := 'C';

    sourceWriter := CoStreamWriter.CreateInstance(fileName);
    try
      provider.GenerateCodeFromCompileUnit(targetUnit, sourceWriter.AsTextWriter, options);
    finally
      sourceWriter.Close;
      sourceWriter.Dispose;
    end;
  end;

/// <summary>
/// Create the CodeDOM graph and generate the code.
/// </summary>
var
  sample: TSample;
begin
  sample := TSample.Create;
  sample.AddFields;
  sample.AddProperties;
  sample.AddMethod;
  sample.AddConstructor;
  sample.AddEntryPoint;
  sample.GenerateCSharpCode(outputFileName);
end.

//* Generated C# File: SampleCode.cs
////--------------------------------------------------------------------------
//// <auto-generated>
////     This code was generated by a tool.
////     Runtime Version:2.0.50727.42
////
////     Changes to this file may cause incorrect behavior and will be lost if
////     the code is regenerated.
//// </auto-generated>
////--------------------------------------------------------------------------
//
//namespace CodeDOMSample
//{
//    using System;
//
//
//    public sealed class CodeDOMCreatedClass
//    {
//
//        // The width of the object.
//        private double widthValue;
//
//        // The height of the object.
//        private double heightValue;
//
//        public CodeDOMCreatedClass(double width, double height)
//        {
//            this.widthValue = width;
//            this.heightValue = height;
//        }
//
//        // The Width property for the object.
//        public double Width
//        {
//            get
//            {
//                return this.widthValue;
//            }
//        }
//
//        // The Height property for the object.
//        public double Height
//        {
//            get
//            {
//                return this.heightValue;
//            }
//        }
//
//        // The Area property for the object.
//        public double Area
//        {
//            get
//            {
//                return (this.widthValue * this.heightValue);
//            }
//        }
//
//        public override string ToString()
//        {
//            return string.Format(
//                "The object:\r\n width = {0},\r\n height = {1},\r\n area = {2}",
//                this.Width, this.Height, this.Area);
//        }
//
//        public static void Main()
//        {
//            CodeDOMCreatedClass testClass = new CodeDOMCreatedClass(5.3, 6.9);
//            System.Console.WriteLine(testClass.ToString());
//        }
//    }
//}
