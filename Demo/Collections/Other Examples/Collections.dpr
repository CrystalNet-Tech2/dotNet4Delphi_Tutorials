program Collections;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils,
{$ELSE}
  SysUtils,
{$IFEND }
  CNClrLib.Host, CNClrLib.Core, CNClrLib.Collections,
  CNClrLib.TypeNames, CNClrLib.Host.Helper;

var
  Console: _Console;
  NamesArray : _StringArray;
  NamesEnumerator: _IEnumerator;
  ArrayList: _ArrayList;
  StringList: _StringCollection;
  StringDictionary: _StringDictionary;
  StringDictValuesEnumerator: _IEnumerator;
  SortedListValuesEnumerator: _IEnumerator;
  HashTableKeysEnumerator: _IEnumerator;
  AEnumerator: _IEnumerator;
  Stack: _Stack;
  Queue: _Queue;
  BitArray: _BitArray;
  HashTable: _Hashtable;
  SortedList: _SortedList;
  I, P: Integer;

begin
  try
    Console := CoConsole.CreateInstance;

    //========================================================================
    //                    Using _IEnumerable Interface
    //========================================================================
    //An enumerator is an object that provides a forward, read-only cursor for a set of items.
    //The _IEnumerable interface has one method called the GetEnumerator method.
    //This method returns an object that implements the IEnumerator interface.
    //The code snippet below illustrates how an enumerator can be used to iterate
    //though a list or collection of items.

    NamesArray := CoStringArray.CreateInstance(2);
    NamesArray[0] := 'Joydip';
    NamesArray[1] := 'Jini';
    NamesEnumerator := NamesArray.AsIEnumerator;
    while NamesEnumerator.MoveNext do
      Console.WriteLine_12(NamesEnumerator.Current);

    //Note that the GetEnumerator method returns an enumerator object each time it is called.
    //Further, the loop contains the Console.WriteLine_12 statement in its re-initializer portion,
    //which is perfectly valid. The condition being evaluated is whether the MoveNext method
    //returns a value of true. The MoveNext method returns true as long as there are items in
    //the collection. The Current property returns the current object and is automatically typecast
    //to string by making a call to the ToString method implicitly.


    //========================================================================
    //                        Using _ArrayList Interface
    //========================================================================
    //The _ArrayList interface is a dynamic array of heterogeneous objects. Note that in an array
    //we can store only objects of the same type. In an ArrayList, however, we can have different
    //type of objects; these in turn would be stored as object type only.  We can have an ArrayList
    //object that stores integer, float, string, etc., but all these objects would only be stored as
    //object type. An ArrayList uses its indexes to refer to a particular object stored in its collection.
    //The Count property gives the total number of items stored in the ArrayList object.
    //The Capacity property gets or sets the number of items that the ArrayList object can contain.
    //Objects are added using the Add method of the ArrayList and removed using its Remove method.
    //An example of usage of an ArrayList is given below.

    ArrayList := CoArrayList.CreateInstance;
    ArrayList.Add('Joydip');
    ArrayList.Add(100);
    ArrayList.Add(20.5);
    for I := 0 to ArrayList.Count - 1 do
      Console.WriteLine_12(ArrayList[I]);

    //It is to be noted here that the initial capacity of an ArrayList is 16, which is increased once the
    //17th item is stored onto it. This repeated memory allocation and copying of the items can be quite
    //expensive in some situations. For performance reasons we can set the initial capacity of the object
    //of an ArrayList by using the Capacity property or an overloaded constructor of the ArrayList class.
    //This is shown in the example below.

    ArrayList := CoArrayList.CreateInstance;
    ArrayList.Capacity := 3;
    ArrayList.Add('Joydip');
    ArrayList.Add(100);
    ArrayList.Add(20.5);
    for I := 0 to ArrayList.Count - 1 do
      Console.WriteLine_12(ArrayList[I]);


    //========================================================================
    //                  Using _StringCollection Interface
    //========================================================================
    //The StringCollection interface implements the IList interface and is like an ArrayList of strings.
    //The following code example shows how we can work with a StringCollection class.

    StringList := CoStringCollection.CreateInstance;
    StringList.Add('Manashi');
    StringList.Add('Joydip');
    StringList.Add('Jini');
    StringList.Add('Piku');

    for I := 0 to StringList.Count - 1 do
      Console.WriteLine_14(StringList[I]);


    //========================================================================
    //                 Using _StringDictionary Interface
    //========================================================================
    //Similar to the StringCollection interface we have the StringDictionary interface,
    //which is just a Hashtable that has its keys as strings only. Remember that a Hashtable
    //can contain any object type in its key. The following code shows how we can work with a
    //StringDictionary interface.

    StringDictionary := CoStringDictionary.CreateInstance;
    StringDictionary.Add('A', 'Manashi');
    StringDictionary.Add('B','Joydip');
    StringDictionary.Add('C','Jini');
    StringDictionary.Add('D','Piku');

    StringDictValuesEnumerator := StringDictionary.Values.AsIEnumerable.GetEnumerator;
    while StringDictValuesEnumerator.MoveNext do
      Console.WriteLine_14(StringDictValuesEnumerator.Current);


    //========================================================================
    //                        Using _Stack Interface
    //========================================================================
    //The _Stack interface is one that provides a Last-in-First-out (LIFO) collection of items
    //of the System.Object type. The last added item is always at the top of the Stack and is also
    //the first one to be removed. The following code sample shows how we can use a Stack class for
    //LIFO operation on its collection of items.

    Stack := CoStack.CreateInstance;
    Stack.Push('Joydip');
    Stack.Push('Steve');
    Stack.Push('Jini');
    while (Stack.Count > 0) do
      Console.WriteLine_12(Stack.Pop);

    //The Push method is responsible for storing items in the Stack and the method Pop
    //removes them one at a time from the top of the Stack.


    //========================================================================
    //                   Using _Queue Interface
    //========================================================================
    //Unlike the Stack interface, the Queue is a data structure that provides a First-in-First-out
    //collection of items of the Object type. The newly added items are stored at the end or
    //the rear of the Queue and items are deleted from the front of the Queue.
    //The following code shows how the Queue class can be used.

    Queue := CoQueue.CreateInstance;
    Queue.Enqueue('Joydip');
    Queue.Enqueue('Steve');
    Queue.Enqueue('Jini');
    while (Queue.Count > 0) do
      Console.WriteLine_12(Queue.Dequeue);

    //The Enqueue method is responsible for storing items at the rear of the Queue and the method Dequeue
    //removes them one at a time from the front of the Queue.


    //========================================================================
    //                     Using _BitArray Interface
    //========================================================================
    //The BitArray interface can be used to store bits in an array. They can be set to true or false,
    //depending on the parameter supplied at the time of creating the BitArray object.
    //The following is an example of its usage.

    BitArray := CoBitArray.CreateInstance(5, false);
    // Or
    BitArray := CoBitArray.CreateInstance(5, true);
    // Similar to the other collections discussed above, the BitArray interface also contains the
    //Count property to get the number of items stored in this collection of bit values.
    //The following methods of the BitArray class allow logical bit operation.
    // �         And
    // �         Or
    // �         Not
    // �         Xor



    //========================================================================
    //                     Using _Hashtable Interface
    //========================================================================
    //The Hashtable provides a faster way of storage and retrieval of items of the object type.
    //The Hashtable class provides support for key based searching. These keys are unique hash codes that
    //are unique to a specific type.  The GetHashCode method of the Hashtable class returns the hash code
    //for an object instance. The following code snippet shows how we can use a Hashtable interface.

    HashTable := CoHashtable.CreateInstance;
    HashTable.Add(1, 'Joydip');
    HashTable.Add(2, 'Manashi');
    HashTable.Add(3, 'Jini');
    HashTable.Add(4, 'Piku');
    Console.WriteLine_14('The keys are:--');
    HashTableKeysEnumerator := HashTable.Keys.AsIEnumerable.GetEnumerator;
    while HashTableKeysEnumerator.MoveNext do
      Console.WriteLine_12(HashTableKeysEnumerator.Current);

    try
      Console.WriteLine_14('Please enter the key to search');
      p := TClrInt32Helper.Parse(Console.ReadLine);
      Console.WriteLine_12(HashTable[p]);
    except
      on E: Exception do
        Console.WriteLine_12(E.Message);
    end;

    //To remove an item from the Hashtable interface, the Remove method is used.
    //The statement HashTable.Remove(3) would remove the item "Jini" from the Hashtable
    //object created in the above code.  The code shown above can also be written as shown below
    //to display the contents of the Hashtable object using IDictionaryEnumerator.

    HashTable := CoHashtable.CreateInstance;
    HashTable.Add(1, 'Joydip');
    HashTable.Add(2, 'Manashi');
    HashTable.Add(3, 'Jini');
    HashTable.Add(4, 'Piku');
    Console.WriteLine_14('The keysare:--');
    AEnumerator := HashTable.GetEnumerator.AsIEnumerator;
    while AEnumerator.MoveNext do
      Console.WriteLine_12(HashTable[p]);


    //========================================================================
    //                     Using _SortedList Interface
    //========================================================================
    //The _SortedList interface allows items of the Object type to be placed in the
    //collection using key value pairs and, at the same time, supports sorting.
    //The following code shows how we can use a SortedList.

    SortedList := CoSortedList.CreateInstance;
    SortedList.Add(1, 'Manashi');
    SortedList.Add(3, 'Joydip');
    SortedList.Add(2, 'Jini');
    SortedList.Add(4, 'Piku');

    Console.WriteLine_14('Displaying thenames');

    SortedListValuesEnumerator:= SortedList.Values.AsIEnumerable.GetEnumerator;
    while SortedListValuesEnumerator.MoveNext do
      Console.WriteLine_14(SortedListValuesEnumerator.Current);

    //The output of the above code is:
    //  Manashi
    //  Jini
    //  Joydip
    //  Piku

    //The same code can be written using IDictionaryEnumerator to display all the items of the
    //SortedList object, as shown below.

    SortedList := CoSortedList.CreateInstance;
    SortedList.Add(1, 'Manashi');
    SortedList.Add(3, 'Joydip');
    SortedList.Add(2, 'Jini');
    SortedList.Add(4, 'Piku');
    Console.WriteLine_14('Displaying thenames');
    AEnumerator := SortedList.Values.AsIEnumerable.GetEnumerator;
    while AEnumerator.MoveNext do
      Console.WriteLine_12(AEnumerator.Current);

    Console.ReadKey;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

