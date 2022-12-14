--@author Irena Bojanova(ivb)
--@date - 12/9/2022
 
 declare @data xml = '<BF Name="Bugs Framework">
	<Cluster Name="_INP" Title="Input/Outpu Bugs Classes" Type="Weakness">
		<Class Name="DVL" Title="Data Validation Bugs">
			<Operations>
				<Operation Name="Validate"/>
				<Operation Name="Sanitize"/>
				<Attribute Name="Mechanism">
					<Value Name="Safelist"/>
					<Value Name="Denylist"/>
					<Value Name="Format"/>
					<Value Name="Length"/>
				</Attribute>
				<Attribute Name="Source Code">
					<Value Name="Codebase"/>
					<Value Name="Third Party"/>
					<Value Name="Standard Library"/>
					<Value Name="Compiler/Interpreter"/>
				</Attribute>
				<Attribute Name="Execution Space">
					<Value Name="Local"/>
					<Value Name="Admin"/>
					<Value Name="Bare-Metal"/>
				</Attribute>
			</Operations>
			<Operands>
				<Operand Name="Data">
					<Attribute Name="State">
						<Value Name="Entered"/>
						<Value Name="Stored"/>
						<Value Name="In Use"/>
						<Value Name="Transferred"/>
					</Attribute>
				</Operand>
			</Operands>
			<Causes>
				<Bug Name="Code Error">
					<Value Name="Missing Code"/>
					<Value Name="Erroneous Code"/>
				</Bug>
				<Bug Name="Specification Error">
					<Value Name="Under-Restrictive Policy"/>
					<Value Name="Over-Restrictive Policy"/>
					<Value Name="Corrupted Policy Data"/>
					<Value Name="Tampered Policy Data"/>
				</Bug>
				<OperandError Name="Data Error">
					<Value Name="Corrupted Data"/>
					<Value Name="Tampered Data"/>
				</OperandError>
			</Causes>
			<Consequences>
				<OperandError Name="Type Error">
					<Value Name="Invalid Data"/>
				</OperandError>
				<FinalError Name="Injection Final Error">
					<Value Name="Query Injection"/>
					<Value Name="Command Injection"/>
					<Value Name="Source Code Injection"/>
					<Value Name="Parameter Injection"/>
					<Value Name="File Injection"/>
				</FinalError>
			</Consequences>
		</Class>
		<Class Name="DVR" Title="Data Verification Bugs">
			<Operations>
				<Operation Name="Verify"/>
				<Operation Name="Correct"/>
				<Attribute Name="Mechanism">
					<Value Name="Value"/>
					<Value Name="Quantity"/>
					<Value Name="Range"/>
					<Value Name="Type"/>
					<Value Name="Other Rules"/>
				</Attribute>
				<Attribute Name="Source Code">
					<Value Name="Codebase"/>
					<Value Name="Third Party"/>
					<Value Name="Standard Library"/>
					<Value Name="Compiler/Interpreter"/>
				</Attribute>
				<Attribute Name="Execution Space">
					<Value Name="Local"/>
					<Value Name="Admin"/>
					<Value Name="Bare-Metal"/>
				</Attribute>
			</Operations>
			<Operands>
				<Operand Name="Data">
					<Attribute Name="State">
						<Value Name="Entered"/>
						<Value Name="Stored"/>
						<Value Name="In Use"/>
						<Value Name="Transferred"/>
					</Attribute>
				</Operand>
			</Operands>
			<Causes>
				<Bug Name="Code Error">
					<Value Name="Missing Code"/>
					<Value Name="Erroneous Code"/>
				</Bug>
				<Bug Name="Specification Error">
					<Value Name="Under-Restrictive Policy"/>
					<Value Name="Over-Restrictive Policy"/>
				</Bug>
				<OperandError Name="Type Error">
					<Value Name="Invalid Data"/>
				</OperandError>
			</Causes>
			<Consequences>
				<OperandError Name="Data Error">
					<Value Name="Wrong Value"/>
					<Value Name="Inconsistent Value"/>
				</OperandError>
				<OperandError Name="Type Error">
					<Value Name="Wrong Type"/>
				</OperandError>
			</Consequences>
		</Class>
	</Cluster>
	<Cluster Name="_DAT" Title="Data Type Bugs Classes" Type="Weakness">
		<Class Name="DCL" Title="Declaration Bugs">
			<Operations>
				<Operation Name="Declare"/>
				<Operation Name="Define"/>
				<Attribute Name="Mechanism">
					<Value Name="Simple"/>
					<Value Name="Generics"/>
					<Value Name="Overriding"/>
					<Value Name="Overloading"/>
				</Attribute>
				<Attribute Name="Source Code">
					<Value Name="Codebase"/>
					<Value Name="Third Party"/>
					<Value Name="Standard Library"/>
					<Value Name="Compiler/Interpreter"/>
				</Attribute>
				<Attribute Name="Entity">
					<Value Name="Object"/>
					<Value Name="Function"/>
					<Value Name="Data Type"/><!--XXXsame as operand
					-->
					<Value Name="Namespace"/>
				</Attribute>
			</Operations>
			<Operands>
				<Operand Name="Type"><!--XXX-->
					<Attribute Name="Type Kind">
						<Value Name="Primitive"/>
						<Value Name="Structure"/>
					</Attribute>
				</Operand>
			</Operands>
			<Causes>
				<Bug Name="Code Error">
					<Value Name="Missing Code"/>
					<Value Name="Wrong Code"/>
					<Value Name="Erroneous Code"/>
				</Bug>
				<Bug Name="Specification Error">
					<Value Name="Missing Modifier"/>
					<Value Name="Wrong Modifier"/>
					<Value Name="Anonymous Scope"/>
					<Value Name="Wrong Scope"/>
				</Bug>
				<OperandError Name="Type Error">
					<Value Name="Wrong Type Resolved"/>
				</OperandError>
			</Causes>
			<Consequences>
				<OperandError Name="Type Error">
					<Value Name="Wrong Type"/>
					<Value Name="Incomplete Type"/>
					<Value Name="Wrong Generic Type"/>
					<Value Name="Confused Subtype"/>
					<Value Name="Wrong Argument Type"/>
				</OperandError>
				<OperandError Name="Name Error">
					<Value Name="Missing Overridden Function"/>
					<Value Name="Missing Overloaded Function"/>
				</OperandError>
				<FinalError Name="Access Final Error">
					<Value Name="Wrong Access Object"/>
					<Value Name="Wrong Access Type"/>
					<Value Name="Wrong Access Function"/>
				</FinalError>
			</Consequences>
		</Class>
		<Class Name="NRS" Title="Name Resolution Bugs">
			<Operations>
				<Operation Name="Refer"/>
				<Operation Name="Call"/>
				<Attribute Name="Mechanism">
					<Value Name="Resolve"/>
					<Value Name="Bind"/>
					<Value Name="Early Bind"/>
					<Value Name="Late Bind"/>
					<Value Name="Ad-hoc Bind"/>
				</Attribute>
				<Attribute Name="Source Code">
					<Value Name="Codebase"/>
					<Value Name="Third Party"/>
					<Value Name="Standard Library"/>
					<Value Name="Compiler/Interpreter"/>
				</Attribute>
				<Attribute Name="Entity">
					<Value Name="Object"/>
					<Value Name="Function"/>
					<Value Name="Data Type"/>
					<Value Name="Namespace"/>
				</Attribute>
			</Operations>
			<Operands>
				<Operand Name="Type">
					<Attribute Name="Type Kind">
						<Value Name="Primitive"/>
						<Value Name="Structure"/>
					</Attribute>
				</Operand>
				<Operand Name="Function"/>
			</Operands>
			<Causes>
				<Bug Name="Code Error">
					<Value Name="Erroneous Code"/>
				</Bug>
				<Bug Name="Specification Error">
					<Value Name="Missing Qualifier"/>
					<Value Name="Wrong Qualifier"/>
				</Bug>
				<OperandError Name="Type Error">
					<Value Name="Incomplete Type"/>
					<Value Name="Wrong Generic Type"/>
					<Value Name="Confused Subtype"/>
					<Value Name="Wrong Argument Type"/>
				</OperandError>
				<OperandError Name="Name Error">
					<Value Name="Missing Overridden Function"/>
					<Value Name="Missing Overloaded Function"/>
				</OperandError>
			</Causes>
			<Consequences>
				<OperandError Name="Data Error">
					<Value Name="Wrong Object Resolved"/>
				</OperandError>
				<OperandError Name="Type Error">
					<Value Name="Wrong Type Resolved"/>
				</OperandError>
				<OperandError Name="Name Error">
					<Value Name="Wrong Function Resolved"/>
					<Value Name="Wrong Generic Function Bound"/>
					<Value Name="Wrong Overridden Function Bound"/>
					<Value Name="Wrong Overloaded Function Bound"/>
				</OperandError>
			</Consequences>
		</Class>
		<Class Name="TCV" Title="Type Conversion Bugs">
			<Operations>
				<Operation Name="Cast"/>
				<Operation Name="Coerce"/>
				<Attribute Name="Mechanism">
					<Value Name="Pass In"/>
					<Value Name="Pass Out"/>
				</Attribute>
				<Attribute Name="Source Code">
					<Value Name="Codebase"/>
					<Value Name="Third Party"/>
					<Value Name="Standard Library"/>
					<Value Name="Compiler/Interpreter"/>
				</Attribute>
			</Operations>
			<Operands>
				<Operand Name="Data">
					<Attribute Name="Data Kind">
						<Value Name="Numeric"/>
						<Value Name="Text"/>
						<Value Name="Pointer"/>
						<Value Name="Boolean"/>
					</Attribute>
				</Operand>
				<Operand Name="Type">
					<Attribute Name="Type Kind">
						<Value Name="Primitive"/>
						<Value Name="Structure"/>
					</Attribute>
				</Operand>
				<Operand Name="Function"/>
			</Operands>
			<Causes>
				<Bug Name="Code Error">
					<Value Name="Wrong Code"/>
					<Value Name="Missing Code"/>
				</Bug>
				<OperandError Name="Data Error">
					<Value Name="Under Range"/>
					<Value Name="Over Range"/>
					<Value Name="Flipped Sign"/>
					<Value Name="Wrong Object Resolved"/>
				</OperandError>
				<OperandError Name="Type Error">
					<Value Name="Wrong Type"/>
					<Value Name="Wrong Object Type Resolved"/>
					<Value Name="Mismatched Argument"/>
				</OperandError>
				<OperandError Name="Name Error">
					<Value Name="Missing Overloaded Function"/>
				</OperandError>
			</Causes>
			<Consequences>
				<OperandError Name="Data Error">
					<Value Name="Wrong Value"/>
					<Value Name="Truncated Value"/>
					<Value Name="Distorted Value"/>
					<Value Name="Rounded Value"/>
				</OperandError>
				<OperandError Name="Type Error">
					<Value Name="Wrong Type"/>
				</OperandError>
			</Consequences>
		</Class>
		<Class Name="TCM" Title="Type Computation Bugs">
			<Operations>
				<Operation Name="Calculate"/>
				<Operation Name="Evaluate"/>
				<Attribute Name="Mechanism">
					<Value Name="Function"/>
					<Value Name="Operator"/>
					<Value Name="Method"/>
					<!-- (for classes)-->
					<Value Name="Lambda Expression"/>
					<Value Name="Procedure"/>
				</Attribute>
				<Attribute Name="Source Code">
					<Value Name="Codebase"/>
					<Value Name="Third Party"/>
					<Value Name="Standard Library"/>
					<Value Name="Compiler/Interpreter"/>
				</Attribute>
			</Operations>
			<Operands>
				<Operand Name="Data">
					<Attribute Name="Data Kind">
						<Value Name="Numeric"/>
						<Value Name="Text"/>
						<Value Name="Pointer"/>
						<Value Name="Boolean"/>
					</Attribute>
				</Operand>
				<Operand Name="Type">
					<Attribute Name="Type Kind">
						<Value Name="Primitive"/>
						<Value Name="Structure"/>
					</Attribute>
				</Operand>
				<Operand Name="Function"/>
			</Operands>
			<Causes>
				<Bug Name="Code Error">
					<Value Name="Wrong Code"/>
					<Value Name="Erroneous Code"/>
				</Bug>
				<OperandError Name="Data Error">
					<Value Name="Wrong Argument"/>
					<Value Name="Wrong Object Resolved"/>
					<Value Name="Reference vs. Object"/>
				</OperandError>
				<OperandError Name="Type Error">
					<Value Name="Wrong Type"/>
					<Value Name="Wrong Object Type Resolved"/>
				</OperandError>
				<OperandError Name="Name Error">
					<Value Name="Wrong Function Resolved"/>
					<Value Name="Wrong Generic Function Bound"/>
					<Value Name="Wrong Overridden Function Bound"/>
					<Value Name="Wrong Overloaded Function Bound"/>
				</OperandError>
			
		</Causes>
			<Consequences>
				<OperandError Name="Data Error">
					<Value Name="Under Range"/>
					<Value Name="Over Range"/>
					<Value Name="Flipped Sign"/>
					<Value Name="Wrong Result"/>
					<Value Name="Wrap Around"/>
				</OperandError>
				<FinalError Name="Type Compute Final Error">
					<Value Name="Undefined"/>
				</FinalError>
			</Consequences>
		</Class>
	</Cluster>
	<Cluster Name="_MEM" Title="Memory Bugs Classes" Type="Weakness">
		<Class Name="MAD" Title="Memory Addressing Bugs">
			<Operations>
				<Operation Name="Initialize"/>
				<Operation Name="Reposition"/>
				<Operation Name="Reassign"/>
				<Attribute Name="Mechanism">
					<Value Name="Direct"/>
					<Value Name="Sequential"/>
				</Attribute>
				<Attribute Name="Source Code">
					<Value Name="Codebase"/>
					<Value Name="Third Party"/>
					<Value Name="Standard Library"/>
					<Value Name="Compiler/Interpreter"/>
				</Attribute>
				<Attribute Name="Execution Space">
					<Value Name="Userland"/>
					<Value Name="Kernel"/>
					<Value Name="Bare-Metal"/>
				</Attribute>
			</Operations>
			<Operands>
				<Operand Name="Data"/>
				<Operand Name="Type"/>
				<Operand Name="Address">
					<!--in MEM paper, this is operand Object-->
					<Attribute Name="Location">
						<Value Name="Stack"/>
						<Value Name="Heap"/>
						<Value Name="/other/"/>
					</Attribute>
				</Operand>
				<Operand Name="Size"/>
			</Operands>
			<Causes>
				<Bug Name="Code Error">
					<Value Name="Missing Code"/>
					<Value Name="Mismatched Operation"/>
					<Value Name="Erroneous Code"/>
				</Bug>
				<OperandError Name="Data Error">
					<Value Name="Hardcoded Address"/>
					<Value Name="Wrong Index"/>
					<Value Name="Wrong Size Used"/>
				</OperandError>
				<OperandError Name="Type Error">
					<Value Name="Wrong Index Type"/>
					<Value Name="Casted Pointer"/>
				</OperandError>
				<OperandError Name="Address Error">
					<Value Name="NULL Pointer"/>
					<Value Name="Wild Pointer"/>
					<Value Name="Dangling Pointer"/>
					<Value Name="Untrusted Pointer"/>
					<Value Name="Under Bounds Pointer"/>
					<Value Name="Wrong Position Pointer"/>
					<Value Name="Over Bounds Pointer"/>
				</OperandError>
				<OperandError Name="Size Error">
					<Value Name="Not Enough Memory Allocated"/>
				</OperandError>
			</Causes>
			<Consequences>
				<OperandError Name="Data Error">
					<Value Name="Forbidden Address"/>
				</OperandError>
				<OperandError Name="Type Error">
					<Value Name="Casted Pointer"/>
				</OperandError>
				<OperandError Name="Address Error">
					<Value Name="NULL Pointer"/>
					<Value Name="Wild Pointer"/>
					<Value Name="Dangling Pointer"/>
					<Value Name="Untrusted Pointer"/>
					<Value Name="Under Bounds Pointer"/>
					<Value Name="Over Bounds Pointer"/>
					<Value Name="Wrong Position Pointer"/>
				</OperandError>
			</Consequences>
		</Class>
		<Class Name="MAL" Title="Memory Allocation Bugs">
			<Operations>
				<Operation Name="Allocate"/>
				<Operation Name="Extend"/>
				<Operation Name="Reallocate-Extend"/>
				<Attribute Name="Mechanism">
					<Value Name="Implicit"/>
					<Value Name="Explicit"/>
				</Attribute>
				<Attribute Name="Source Code">
					<Value Name="Codebase"/>
					<Value Name="Third Party"/>
					<Value Name="Standard Library"/>
					<Value Name="Compiler/Interpreter"/>
				</Attribute>
				<Attribute Name="Execution Space">
					<Value Name="Userland"/>
					<Value Name="Kernel"/>
					<Value Name="Bare-Metal"/>
				</Attribute>
			</Operations>
			<Operands>
				<Operand Name="Data"/>
				<Operand Name="Address">
					<Attribute Name="Ownership">
						<Value Name="None"/>
						<Value Name="Single"/>
						<Value Name="Shared"/>
					</Attribute>
					<Attribute Name="Location">
						<Value Name="Stack"/>
						<Value Name="Heap"/>
						<Value Name="/other/"/>
					</Attribute>
				</Operand>
			</Operands>
			<Causes>
				<Bug Name="Code Error">
					<Value Name="Missing Code"/>
					<Value Name="Mismatched Operation"/>
					<Value Name="Erroneous Code"/>
				</Bug>
				<OperandError Name="Data Error">
					<Value Name="Hardcoded Address"/>
					<Value Name="Forbidden Address"/>
					<Value Name="Single Owned Address"/>
					<Value Name="Wrong Size Used"/>
				</OperandError>
				<OperandError Name="Address Error">
					<Value Name="Wild Pointer"/>
					<Value Name="Dangling Pointer"/>
					<Value Name="Wrong Position Pointer"/>
				</OperandError>
			</Causes>
			<Consequences>
				<OperandError Name="Address Error">
					<Value Name="NULL Pointer"/>
					<Value Name="Wild Pointer"/>
				</OperandError>
				<OperandError Name="Size Error">
					<Value Name="Not Enough Memory Allocated"/>
					<!--xxx Wrong Size Memory Allocated - not enough; too much; or just add Too Much Memory Allocated ???-->
				</OperandError>
				<FinalError Name="Memory Final Error">
					<Value Name="Memory Overflow"/>
					<Value Name="Memory Leak"/>
					<Value Name="Double Free"/>
					<Value Name="Object Corruption"/>
				</FinalError>
			</Consequences>
		</Class>
		<Class Name="MUS" Title="Memory Use Bugs" Definition="An object is initialized, read, written, or cleared improperly.">
			<Operations>
				<Operation Name="Initialize"/>
				<Operation Name="Dereference"/>
				<Operation Name="Read"/>
				<Operation Name="Write"/>
				<Operation Name="Clear"/>
				<Attribute Name="Mechanism">
					<Value Name="Direct"/>
					<Value Name="Sequential"/>
				</Attribute>
				<Attribute Name="Source Code">
					<Value Name="Codebase"/>
					<Value Name="Third Party"/>
					<Value Name="Standard Library"/>
					<Value Name="Compiler/Interpreter"/>
				</Attribute>
				<Attribute Name="Execution Space">
					<Value Name="Userland"/>
					<Value Name="Kernel"/>
					<Value Name="Bare-Metal"/>
				</Attribute>
			</Operations>
			<Operands>
				<Operand Name="Data"/>
				<Operand Name="Type"/>
				<Operand Name="Address">
					<Attribute Name="Span">
						<Value Name="Litle"/>
						<Value Name="Moderate"/>
						<Value Name="Huge"/>
					</Attribute>
					<Attribute Name="Location">
						<Value Name="Stack"/>
						<Value Name="Heap"/>
						<Value Name="/other/"/>
					</Attribute>
				</Operand>
				<Operand Name="Size"/>
			</Operands>
			<Causes>
				<Bug Name="Code Error">
					<Value Name="Missing Code"/>
					<Value Name="Mismatched Operation"/>
					<Value Name="Erroneous Code"/>
				</Bug>
				<OperandError Name="Data Error">
					<Value Name="Forbidden Address"/>
					<Value Name="Wrong Size Used"/>
				</OperandError>
				<OperandError Name="Type Error">
					<Value Name="Casted Pointer"/>
				</OperandError>
				<OperandError Name="Address Error">
					<Value Name="NULL Pointer"/>
					<Value Name="Wild Pointer"/>
					<Value Name="Dangling Pointer"/>
					<Value Name="Untrusted Pointer"/>
					<Value Name="Under Bounds Pointer"/>
					<Value Name="Over Bounds Pointer"/>
					<Value Name="Wrong Position Pointer"/>
				</OperandError>
				<OperandError Name="Size Error">
					<Value Name="Not Enough Memory Allocated"/>
				</OperandError>
			</Causes>
			<Consequences>
				<FinalError Name="Memory Final Error">
					<Value Name="Uninitialized Object"/>
					<Value Name="Not Cleared Object"/>
					<Value Name="NULL Pointer Dereference"/>
					<Value Name="Untrusted Pointer Dereference"/>
					<Value Name="Object Corruption"/>
					<Value Name="Type Confusion"/>
					<Value Name="Use After Free"/>
					<Value Name="Buffer Overflow"/>
					<Value Name="Buffer Underflow"/>
					<Value Name="Uninitialized Pointer Dereference"/>
				</FinalError>
			</Consequences>
		</Class>
		<Class Name="MDL" Title="Memory Deallocation Bugs">
			<Operations>
				<Operation Name="Deallocate"/>
				<Operation Name="Reduce"/>
				<Operation Name="Reallocate-Reduce"/>
				<Attribute Name="Mechanism">
					<Value Name="Implicit"/>
					<Value Name="Explicit"/>
				</Attribute>
				<Attribute Name="Source Code">
					<Value Name="Codebase"/>
					<Value Name="Third Party"/>
					<Value Name="Standard Library"/>
					<Value Name="Compiler/Interpreter"/>
				</Attribute>
				<Attribute Name="Execution Space">
					<Value Name="Userland"/>
					<Value Name="Kernel"/>
					<Value Name="Bare-Metal"/>
				</Attribute>
			</Operations>
			<Operands>
				<Operand Name="Data"/>
				<Operand Name="Address">
					<Attribute Name="Ownership">
						<Value Name="None"/>
						<Value Name="Single"/>
						<Value Name="Shared"/>
					</Attribute>
					<Attribute Name="Location">
						<Value Name="Stack"/>
						<Value Name="Heap"/>
						<Value Name="/other/"/>
					</Attribute>
				</Operand>
				<Operand Name="Size"/>
			</Operands>
			<Causes>
				<Bug Name="Code Error">
					<Value Name="Missing Code"/>
					<Value Name="Mismatched Operation"/>
					<Value Name="Erroneous Code"/>
				</Bug>
				<OperandError Name="Data Error">
					<Value Name="Hardcoded Address"/>
					<Value Name="Forbidden Address"/>
					<Value Name="Wrong Size Used"/>
				</OperandError>
				<OperandError Name="Address Error">
					<Value Name="Wild Pointer"/>
					<Value Name="Dangling Pointer"/>
					<Value Name="Wrong Position Pointer"/>
				</OperandError>
				<OperandError Name="Size Error">
					<Value Name="Not Enough Memory Allocated"/>
				</OperandError>
			</Causes>
			<Consequences>
				<OperandError Name="Address Error">
					<Value Name="NULL Pointer"/>
				</OperandError>
				<OperandError Name="Size Error">
					<Value Name="Not Enough Memory Allocated"/>
				</OperandError>
				<FinalError Name="Memory Final Error">
					<Value Name="Memory Leak"/>
					<Value Name="Double Free"/>
					<Value Name="Object Corruption"/>
				</FinalError>
			</Consequences>
		</Class>
	</Cluster>

	<Cluster Name="_FLR" Title="Security Failures Classes" Type="Failure">
		<Class Name="IEX" Title="Information Exposure">
			<Operations>
				<Operation Name="IEX Operation"/>
			</Operations>
			<Causes>
				<FianalError Name="Access Final Error">
					<Value Name="Wrong Access Function"/>
					<Value Name="Wrong Access Object"/>
					<Value Name="Wrong Access Type"/>
				</FianalError>
				<FianalError Name="Injection Final Error">
					<Value Name="Command Injection"/>
					<Value Name="File Injection"/>
					<Value Name="Parameter Injection"/>
					<Value Name="Query Injection"/>
					<Value Name="Source Code Injection"/>
				</FianalError>
				<FianalError Name="Memory Final Error">
					<Value Name="Memory Overflow"/>
					<Value Name="Memory Leak"/>
					<Value Name="Double Free"/>
					<Value Name="Object Corruption"/>
					<Value Name="Uninitialized Object"/>
					<Value Name="Not Cleared Object"/>
					<Value Name="NULL Pointer Dereference"/>
					<Value Name="Untrusted Pointer Dereference"/>
					<Value Name="Object Corruption"/>
					<Value Name="Type Confusion"/>
					<Value Name="Use After Free"/>
					<Value Name="Buffer Overflow"/>
					<Value Name="Buffer Underflow"/>
					<Value Name="Uninitialized Pointer Dereference"/>
				</FianalError>
				<FianalError Name="Type Compute Final Error">
					<Value Name="Undefined"/>
				</FianalError>
			</Causes>
			<Consequences>
				<Risk Name="Risk">
					<Value Name="IEX Conseqeunce"/>
				</Risk>
			</Consequences>
		</Class>
		<!-- Changed RCE to ACE Arbitrary code execution, xxx Remote should be a value of an attribute of the class-->
		<Class Name="ACE" Title="Arbitrary Code Execution">
			<Operations>
				<Operation Name="ACE Operation"/>
			</Operations>
			<Causes>
				<FianalError Name="Access Final Error">
					<Value Name="Wrong Access Function"/>
					<Value Name="Wrong Access Object"/>
					<Value Name="Wrong Access Type"/>
				</FianalError>
				<FianalError Name="Injection Final Error">
					<Value Name="Command Injection"/>
					<Value Name="File Injection"/>
					<Value Name="Parameter Injection"/>
					<Value Name="Query Injection"/>
					<Value Name="Source Code Injection"/>
				</FianalError>
				<FianalError Name="Memory Final Error">
					<Value Name="Memory Overflow"/>
					<Value Name="Memory Leak"/>
					<Value Name="Double Free"/>
					<Value Name="Object Corruption"/>
					<Value Name="Uninitialized Object"/>
					<Value Name="Not Cleared Object"/>
					<Value Name="NULL Pointer Dereference"/>
					<Value Name="Untrusted Pointer Dereference"/>
					<Value Name="Object Corruption"/>
					<Value Name="Type Confusion"/>
					<Value Name="Use After Free"/>
					<Value Name="Buffer Overflow"/>
					<Value Name="Buffer Underflow"/>
					<Value Name="Uninitialized Pointer Dereference"/>
				</FianalError>
				<FianalError Name="Type Compute Final Error">
					<Value Name="Undefined"/>
				</FianalError>
			</Causes>
			<Consequences>
				<Risk Name="Risk">
					<Value Name="RCE Conseqeunce"/>
				</Risk>
			</Consequences>
		</Class>
		<Class Name="DOS" Title="Denial of Service">
			<Operations>
				<Operation Name="DOS Operation"/>
			</Operations>
			<Causes>
				<FianalError Name="Access Final Error">
					<Value Name="Wrong Access Function"/>
					<Value Name="Wrong Access Object"/>
					<Value Name="Wrong Access Type"/>
				</FianalError>
				<FianalError Name="Injection Final Error">
					<Value Name="Command Injection"/>
					<Value Name="File Injection"/>
					<Value Name="Parameter Injection"/>
					<Value Name="Query Injection"/>
					<Value Name="Source Code Injection"/>
				</FianalError>
				<FianalError Name="Memory Final Error">
					<Value Name="Memory Overflow"/>
					<Value Name="Memory Leak"/>
					<Value Name="Double Free"/>
					<Value Name="Object Corruption"/>
					<Value Name="Uninitialized Object"/>
					<Value Name="Not Cleared Object"/>
					<Value Name="NULL Pointer Dereference"/>
					<Value Name="Untrusted Pointer Dereference"/>
					<Value Name="Object Corruption"/>
					<Value Name="Type Confusion"/>
					<Value Name="Use After Free"/>
					<Value Name="Buffer Overflow"/>
					<Value Name="Buffer Underflow"/>
					<Value Name="Uninitialized Pointer Dereference"/>
				</FianalError>
				<FianalError Name="Type Compute Final Error">
					<Value Name="Undefined"/>
				</FianalError>
			</Causes>
			<Consequences>
				<Risk Name="Risk">
					<Value Name="DOS Conseqeunce"/>
				</Risk>
			</Consequences>
		</Class>
		<Class Name="TPR" Title="Tempering">
			<Operations>
				<Operation Name="DOS Operation"/>
			</Operations>
			<Causes>
				<FianalError Name="Access Final Error">
					<Value Name="Wrong Access Function"/>
					<Value Name="Wrong Access Object"/>
					<Value Name="Wrong Access Type"/>
				</FianalError>
				<FianalError Name="Injection Final Error">
					<Value Name="Command Injection"/>
					<Value Name="File Injection"/>
					<Value Name="Parameter Injection"/>
					<Value Name="Query Injection"/>
					<Value Name="Source Code Injection"/>
				</FianalError>
				<FianalError Name="Memory Final Error">
					<Value Name="Memory Overflow"/>
					<Value Name="Memory Leak"/>
					<Value Name="Double Free"/>
					<Value Name="Object Corruption"/>
					<Value Name="Uninitialized Object"/>
					<Value Name="Not Cleared Object"/>
					<Value Name="NULL Pointer Dereference"/>
					<Value Name="Untrusted Pointer Dereference"/>
					<Value Name="Object Corruption"/>
					<Value Name="Type Confusion"/>
					<Value Name="Use After Free"/>
					<Value Name="Buffer Overflow"/>
					<Value Name="Buffer Underflow"/>
					<Value Name="Uninitialized Pointer Dereference"/>
				</FianalError>
				<FianalError Name="Type Compute Final Error">
					<Value Name="Undefined"/>
				</FianalError>
			</Causes>
			<Consequences>
				<Risk Name="Risk">
					<Value Name="DOS Conseqeunce"/>
				</Risk>
			</Consequences>
		</Class>
	</Cluster>

	<Definitions>
		<!--Terms Definitions - xxx can use them as tooltips for labels-->
		<Definition Name="Bug">A coding error or a specification error. The first error in a chain of weaknesses. Needs to be fixed<!--xxx to resolve a vulnerability-->.</Definition>
		<Definition Name="Weakness">Caused by a bug or a previous weakness. The chain of weaknesses ends with a final error (undefined or exploitable system behavior). A weakness type is also a meaningful notion, as different vulnerabilities may have the same type of underlying weaknesses.</Definition>
		<Definition Name="Vulnerability">An instance of a weakness type that leads to a security failure. May have more than one underlying weaknesses linked by causality.</Definition>
		<Definition Name="Failure">A violation of a system security requirement. Caused by the final error.<!--xxx In rare ocasions, several chains might converge at the final error to cause the failure.--></Definition>
		<!-- xxxIB: check-->
		<Definition Name="BF Class">A taxonomic category of a weakness type, defined by: a set of operations, all valid cause → consequence relations, and a set of attributes.</Definition>

		<!--Clusters-->
		<Definition Name="_INP">Input/Output Check Bugs - may lead to Injection Error.</Definition>
		<Definition Name="_DAT">Data Type Bugs - may lead to Convert and Type Compute Errors.></Definition>
		<Definition Name="_MEM">Memory Bugs - may lead to Memorry Corruption Errors.</Definition>
		<Definition Name="_CRY">Cryptographic Store or Transfer Bugs - may lead to xxx Error.</Definition>
		<Definition Name="_RND">Random Number Generation Bugs - may lead to xxx Error.</Definition>
		<Definition Name="_ACC">Access Control Bugs - may lead to xxx Error.</Definition>
		<Definition Name="_CON">Concurency Bugs - may lead to xxx Error.</Definition>
		<Definition Name="_CLF">Control Flow Bugs - may lead to xxx Error.</Definition>
		<Definition Name="_FLR">Loss of a Security Property -- consequence from an Error.</Definition>

		<!--Classes - xxx update the definitions on BF web-site-->
		<!--_INP-->
		<Definition Name="DVL">Data are validated (syntax check) or sanitized (escape, filter, repair) improperly.</Definition>
		<Definition Name="DVR">Data are verified (semantics check) or corrected (assign, remove) improperly.</Definition>
		<!--_DAT-->
		<Definition Name="DCL">An object, a function, a type, or a namespace is declared or defined improperly.</Definition>
		<Definition Name="NRS">The name of an object, a function, or a type is resolved improperly or bound to an improper type or implementation.</Definition>
		<Definition Name="TCV">Data are converted or coerced into other type improperly.</Definition>
		<Definition Name="TCM">A numeric, pointer, or string value is calculated improperly of a condition is evaluated improperly.</Definition>
		<!--_MEM-->
		<Definition Name="MAD">The pointer to an object is initialized, repositioned, or reassigned to animproper memory address.</Definition>
		<Definition Name="MAL">An object is allocated, extended, or reallocated (while extending) improperly.</Definition>
		<Definition Name="MUS">An object is initialized, read, written, or cleared improperly.</Definition>
		<Definition Name="MDL">An object is deallocated, reduced, or reallocated (while reducing) improperly.</Definition>
		<!--xxx_CRY-->
		<Definition Name="ENC">Sensitive data (plaintext) are improperly transformed into unintelligible form (ciphertext) using a cryptographic algorithm and key(s).</Definition>
		<Definition Name="VRF">Data is signed, source is checked and proved, or data is assured to be unaltered improperly.</Definition>
		<Definition Name="KMN">Cryptographic keys and other keying material are generated, stored, distributed, used, or destroyed improperly.</Definition>
		<!--xxx_RND-->
		<Definition Name="TRN">A generated output does not satisfy all use-specifictrue-randomness requirements. The output sequence is of random bits, where values are obtained from one or more sources of entropy.</Definition>
		<Definition Name="PRN">A generated output does not satisfy all use-specificpseudo-randomness requirements. The output sequence is of random bits or numbers from a PRNG.</Definition>
		<!--xxx_ACC-->
		<Definition Name="ATN">xxx</Definition>
		<Definition Name="ATZ">xxx</Definition>
		<!--_FLR-->
		<Definition Name="IEX">Confifentiality loss: Unauthorized disclosure of information.</Definition>
		<!--(can read while shoudn''t)-->
		<Definition Name="ACE">xxxEVERYTHING loss: Unauthorized commands or code execution.</Definition>
		<!--Unauthorized run of commands or code.-->
		<Definition Name="DOS">Avaliability loss: Disruption of access/use to information or information system (service).</Definition>
		<!--(cannot read/write while shoud)-->
		<Definition Name="TPR">Integrity loss: Unauthorized modification or destruction of information.</Definition>
		<!--(can write while shoudn''t)-->

		<!--Operations-->
		<!--_inp_operation-->
		<Definition Name="Validate">Check data syntax (proper form/grammar) in order to accept (and possibly sanitize) or reject it. Includes checking for missing symbols/elements.</Definition>
		<Definition Name="Sanitize">Modify data (neutralize/escape, filter/remove, repair/add symbols) in order to make it valid (well-formed).</Definition>
		<Definition Name="Verify">Check data semantics (proper value/meaning) in order to accept (and possibly correct) or reject it.</Definition>
		<Definition Name="Correct">Modify data (assign new value, remove), in order to make it accurate.</Definition>
		<!--_dat_operation-->
		<Definition Name="Declare">Specify name and type of an object; name, return type, and parameters of a function; or name and type parameters of a type.</Definition>
		<Definition Name="Define">Specify data of an object; implementation of a function; or member objects and functions of a type.Refe.</Definition>
		<Definition Name="Refer">Use a name in local or remote scopes of source code. The Type System resolves the name and binds a data type to it.</Definition>
		<Definition Name="Call">Invoke a function implementation. The Type System binds the implementation to the resolved function name. A polymorphic implementation is first resolved and then bound.</Definition>
		<Definition Name="Cast">Explicitly convert the value of an object to another data type.</Definition>
		<Definition Name="Coerce">Implicitly (forced by the Type System) convert the value of a passed in/out argument or the return into the corresponding parameter or return data type. (Type Coercion is known also as Type Juggling.</Definition>
		<Definition Name="Calculate">Find the result of a numeric, pointer, or string operation.</Definition>
		<Definition Name="Evaluate">Find the result of a boolean condition (incl. comparison).</Definition>
		<!--_mem_operation-->
		<Definition Name="Initialize (pointer)">The first assign of an object address to a pointer; positions the pointer at the start of the object.</Definition>
		<Definition Name="Reposition">Changes the pointer to another position inside its object.</Definition>
		<Definition Name="Reassign">Changes the pointer to a different object.</Definition>
		<Definition Name="Allocate">Reserves space in memory for an object; defines its initial boundaries and size.</Definition>
		<Definition Name="Extend">Allocates additional memory for an object in the same space; redefines its boundaries and size.</Definition>
		<Definition Name="Reallocate–Extend">Allocates a new larger piece of memory for an object at a new address, copies the object content there, reassigns its pointer, and deallocates the previous piece of memory.</Definition>
		<Definition Name="Initialize (object)"> The first write into an object, after it is allocated.</Definition>
		<Definition Name="Read">Gets content from an object.</Definition>
		<Definition Name="Write">Puts content into an object.</Definition>
		<Definition Name="Clear">The very last write into an object, before it is deallocated.</Definition>
		<Definition Name="Dereference">Overreaches Initialize, Read, Write, and Clear, focus is on object access, no matter if it’s for reading or for writing.</Definition>
		<Definition Name="Deallocate">Releases the allocated memory of an object.</Definition>
		<Definition Name="Reduce">Deallocates part of the object memory; redefines its boundaries and size.</Definition>
		<Definition Name="Reallocate–Reduce">Allocates a new smaller space in memory for an object at a new address, copies part of the object content there, reassigns the pointer, and deallocates the previous piece of memory.</Definition>

		<!--Bug = Operation Error-->
			<!--code_error -->
			<Definition Name="Missing Code">The entire operation or part of it is absent.</Definition>
			<Definition Name="Erroneous Code">The operation implementation has a bug.</Definition>
				<!--_INP - incl. how it checks against a polic.-->
				<!--_DAT - The Type System or a compute function implementation has a bug.-->
			<!--_DAT-->
			<Definition Name="Wrong Code">An inappropriate data type is specified; or an inappropriate function/operator is used.</Definition>
			<!--_MEM-->
			<Definition Name="Mismatched Operation">The deallocation function does not match the allocation function used for the same object.</Definition>
			<!--specification _error -->
			<!--_INP-->
			<Definition Name="Under-Restrictive Policy">Accepts bad data.</Definition>
			<Definition Name="Over-Restrictive Policy">Rejects good data.</Definition>
			<Definition Name="Corrupted Policy Data">Unintentionally modified policy due to a previous weakness (e.g., with a decompress operation).</Definition>
			<Definition Name="Tampered Policy Data">Maliciously modified policy due to a previous weakness (e.g., with an authorize operation).</Definition>
			<!--_DAT-->
			<Definition Name="Missing Modifier">A required behavioral restriction is absent.</Definition>
			<Definition Name="Wrong Modifier">A wrong behavioral restriction is specified.</Definition>
			<Definition Name="Anonymous Scope">The declaration is in an unnamed scope.</Definition>
			<Definition Name="Wrong Scope">The declaration should be in another scope.</Definition>
			<Definition Name="Missing Qualifier">A namespace include is absent; or a scope is not specified in a fully qualified name.</Definition>
			<Definition Name="Wrong Qualifier">A wrong namespace is included, or a wrong scope is specified in a fully qualified name.</Definition>

		<!--Operand Error-->
		<!--xxx remove all examples - they are saved in comments section at the end - CG: Should we put examples in the definition?-->

		<!--address_error-->
		<!--_MEM-->
		<Definition Name="NULL Pointer">Points to the zero address, a specific invalid address.</Definition>
		<Definition Name="Wild Pointer">Points to an arbitrary address, because it has not been initialized or an erroneous allocation routine is used.</Definition>
		<Definition Name="Dangling Pointer">Still points to the address of its successfully deallocated object.</Definition>
		<Definition Name="Untrusted Pointer">The pointer is modified to an improperly checked address.</Definition>
		<Definition Name="Under Bounds Pointer">Points before/under the lower bound of its object.</Definition>
		<Definition Name="Wrong Position Pointer">Points to a miscalculated position inside its object bounds.</Definition>
		<Definition Name="Over Bounds Pointer">Points after/over the upper bound for its object.</Definition>

		<!--size_error-->
		<Definition Name="Not Enough Memory Allocated">The allocated memory is too little for the data it should store.</Definition>

		<!--type_error-->
		<!--_MEM-->
		<Definition Name="Wrong Index Type">xxx.</Definition>
		<Definition Name="Casted Pointer">The pointer does not match the type of the object, due to wrong type casting.</Definition>
		<!--_DAT-->
		<Definition Name="Wrong Type">Data type range or structure is not correct.</Definition>
		<Definition Name="Incomplete Type">Specific constructor, method, or overloaded function is missing.</Definition>
		<Definition Name="Wrong Generic Type">Generic object instantiated via wrong type argument.</Definition>
		<Definition Name="Confused Subtype">Object invoking an overriden function is of wrong subtype data type.</Definition>
		<Definition Name="Wrong Argument Type">Argument to an overloaded function is of wrong data type.</Definition>
		<Definition Name="Wrong Object Type Resolved">Object is resolved from wrong scope,so it''s data type might be wrong.</Definition>
		<Definition Name="Wrong Type Resolved">Data type is resolved from wrong scope.</Definition>
		<Definition Name="Mismatched Argument Type">Argument''s data type is different from function''s parameter data type.</Definition>

		<!--data_error-->
		<!--_INP-->
		<Definition Name="Corrupted Data">Unintentionally modified data due to a previous weakness (e.g., with a decompress or a decrypt operation) that if not sanitized would end-up as invalid data for next weakness.</Definition>
		<Definition Name="Tampered Data">Maliciously modified data due to a previous weakness (e.g., with a deserialize, authorize, or crypto verify operation) that would lead to injection error.</Definition>
		<Definition Name="Invalid Data">Data with harmed syntax due to sanitization errors.</Definition>
		<Definition Name="Wrong Value">Data value is not accurate value (e.g., outside of a range).</Definition>
			<!--_INP - Data with harmed semantics; not accurate value (e.g., outside of a range).-->
		<Definition Name="Inconsistent Value">Data value is inconsistent with the value of a related data (e.g., inconstancy between the value of a size variable and the actual buffer size).</Definition>
			<!-- _INP - Data with wrong data type.-->
		<!--_DAT-->
		<Definition Name="Wrong Argument">Inaccurate input data value; i.e., non-verified for harmed semantics.</Definition>
		<Definition Name="Wrong Result">Incorrect value from type conversion or computation.</Definition>
		<Definition Name="Truncated Value">Rightmost bits of value that won’t fit type size are cut off.</Definition>
		<Definition Name="Distorted Value">Incorrect value (although fits type size) due to sign flip or signed/unsigned and vice versa conversions.</Definition>
		<Definition Name="Rounded Value">Real number value precision loss.</Definition>
		<Definition Name="Under Range">Data value is smaller than type''s lower range.</Definition>
		<Definition Name="Over Range">Data value is larger than type''s upper range.</Definition>
		<Definition Name="Flipped Sign">Sign bit is overwritten from type related calculation.</Definition>
		<Definition Name="Wrap Around">A moved around-the-clock value over its data type upper or lower range, as it exceeds that range. (Integer Over-/Under-flow is a wrapped-around the upper/lower range integer value; may become very small/large and change to the opposite sign.</Definition>
		<Definition Name="Wrong Object Resolved">Object is resolved from wrong scope, so it''s value might be wrong.</Definition>
		<Definition Name="Reference vs. Object">Object''s address instead of object''s data value.</Definition>
		<!--_MEM-->
		<Definition Name="Forbidden Address">The pointer points to an OS protected or non-existing address.</Definition>
		<Definition Name="Hardcoded Address">The pointer points a wrong specific address.</Definition>
		<Definition Name="Address of Single Owned Object">The only pointer of an already allocated object is used to allocate a new object.</Definition>
		<Definition Name="Wrong Size Used">The value used as size does not match the real size of the object.</Definition>

		<!--function_error-->
		<Definition Name="Missing Overridden Function">Function implementation in a particular subclass is absent.</Definition>
		<Definition Name="Missing Overloaded Function">Implementation for particular function parameters'' data types is absent.</Definition>
		<Definition Name="Wrong Function Resolved">Function is resolved from wrong scope.</Definition>
		<Definition Name="Wrong Generic Function Bound">Implementation for a wrong data type is bound due to wrong generic type arguments.</Definition>
		<Definition Name="Wrong Overridden Function Bound">Implementation from wrong subtype is bound due to a wrong invoking subtype object.</Definition>
		<Definition Name="Wrong Overloaded Function Bound">Wrong overloaded implementation is bound due to wrong function arguments.</Definition>

		<!--Final Errors-->
		<!--memory_error-->
		<!--_MEM-->
		<!--xxxCG: We need to straight up the definitions here. Some are defined as actions (Null pointer dereference) others as things(Type confusion). I think all of them should be defined as action/attempts-->
		<Definition Name="Uninitialized Pointer Dereference">An attempt to access an object for read or write via an uninitialized pointer.</Definition>
		<Definition Name="Memory Overflow">More memory requested than available.</Definition>
		<Definition Name="Memory Leak">An object has no pointer pointing to it.</Definition>
		<Definition Name="Double Free">Attempt to deallocate a deallocated object or via an uninitialized pointer.</Definition>
		<Definition Name="Uninitialized Object">Object data is not filled in before use.</Definition>
		<Definition Name="Not Cleared Object">Object data not overwritten before deallocation.</Definition>
		<Definition Name="NULL Pointer Dereference">Attempt to access an object for read or write through a NULL pointer.</Definition>
		<Definition Name="Untrusted Pointer Dereference">Attempt to access an object via an altered pointer (not legitimate dereference of tainted pointers).</Definition>
		<Definition Name="Object Corruption">Object data is unintentionally altered.</Definition>
		<Definition Name="Type Confusion">Pointer and object have different types.</Definition>
		<Definition Name="Use After Free">Attempt to use a deallocated object.</Definition>
		<Definition Name="Buffer Overflow">Read or write above the object upper bound.</Definition>
		<Definition Name="Buffer Underflow">Read or write below the object lower bounds.</Definition>
		<!--injection_error--> 
		<!--_INP-->
		<Definition Name="Query Injection">Malicious insertion of condition parts (e.g., or 1==1) or entire commands (e.g., drop table) into an input used to construct a database query.</Definition>
		<Definition Name="Command Injection">Malicious insertion of new commands into the input to a command that is sent to an operating system (OS) or to a server.</Definition>
		<Definition Name="Source Code Injection">Malicious insertion of new code (incl. with &lt;&gt; elements) into input used as part of an executing application code.</Definition>
		<Definition Name="Parameter Injection">Malicious insertion of data (e.g., with &amp; parameter separator) into input used as parameter/argument in other parts of code.</Definition>
		<Definition Name="File Injection">Malicious insertion of data (e.g., with .. and / or with file entries) into input used to access/modify files or as file content.</Definition>
		<!--access_error-->
		<!--_DAT-->
		<Definition Name="Wrong Access Object">Unauthorized access to an object exposes sensitive data or allows access to member functions.</Definition>
		<Definition Name="Wrong Access Type">Unauthorized access to a data type allows access to member objects and functions.</Definition>
		<Definition Name="Wrong Access Function">Unauthorized access to a function.</Definition>
		<!--type_compute_error-->
		<!--_DAT-->
		<Definition Name="Undefined">The Type System cannon represent the computation result (e.g. division by 0).</Definition>


		<!-- Atributes-->
		<!--xxx maybe all attribuutes shoud start with "Shows ..."-->
		<!--xxx decide which to use everywhere: buggy operation or bugged code-->

		<!--xxxThe operation attributes Source Code and Execution Space explain where a bug is – where the operation is in the program and where its code runs.-->
		<Definition Name="Mechanism">Shows how the buggy operation is performed.</Definition>
		<Definition Name="Source Code">Shows in what kind of software the buggy operation is.</Definition>
		<Definition Name="Execution Space">Shows where the buggy operation code is running.</Definition>
		<Definition Name="Policy">Lists or rules for checking data syntax and semantics. </Definition>
		<Definition Name="Entity">Each data type related operation is over an entity - object, function, data type, or namespace - referred in source code via its declared name.</Definition>
		<!--Each data type bug or weakness involves one data type related operation. Each of these operations is over an entity: object, function, data type, or namespace. An entity is referred in source code via its declared name.-->
		<Definition Name="Type Kind">Primitive, Structured. A data type can be a primitive data type (scalar) or a structured data type (composite).</Definition>
		<Definition Name="Data Kind">Numeric, Text, Pointer, Boolean.</Definition>
		<Definition Name="Location">Memory region where objects are allocated.</Definition>
		<Definition Name="Ownership">Responsabile for cleaning and deallocating object''s memory.</Definition>

		<!--Bug - OperationError-->
		<Definition Name="Code Error">The bug in the operation. The first cause for the chain of weaknesses commprising a software security vulnerability. It has to be fixed to resolve the vulnerability.</Definition>
		<Definition Name="Specification Error">An error in the rules (policy, algorithm, keying material, gomain parameter) used by the operation, that when implemented becomes the bug causing the chain of weaknesses commprising a software security vulnerability. It has to be fixed to resolve the vulnerability.</Definition>

		<!--OperandError-->
		<Definition Name="Size Error">The used object size is wrong.</Definition>
		<Definition Name="Address Error">The used object address is wrong.</Definition>
		<Definition Name="Type Error">The set or range of allowed values is wrong or the operations allowed on them are wrong.</Definition>
		<!--A data type defines a set or a range of values (e.g. char is [-128, 127]) and the operations allowed over them (e.g. +, *, mod).-->
		<Definition Name="Data Error" >Has harmed semantics or inconsistent or wrong value <!--xxx or type--> for its intended use.</Definition>
		<!--xxxNOTE: Improper Data in DVL is like the parent of Improper Data Value and Improper Data Type - so each of these should be able to connect to an Improper Data cause for next weakness-->		
		
		<Definition Name="Name Error">xxx need better text - An organized block of code that when called takes in data, processes it, and produces an unexpected result(s).</Definition>
		<!-- CG: adapted from MEM paper-->
		<Definition Name="Improper Object">xxx need better text - This is the higher level of Data, Type, Address, Size, Function -- A piece of memory, with a ill-defined size.</Definition>
		
		<!--xxx???FinalErrors https://blog.klipse.tech/databook/2020/10/02/separate-code-data.html -->
		<Definition Name="Injection Final Error">Undefined or exploitable system behavior caused by executing user controlled data. OR Undefined or exploitable system behavior caused by bugs in separating code and data</Definition>
		<!-- xxxCG: do we keep system or just software? Adapted from MEM paper-->
		<Definition Name="Memory Final Error">Undefined or exploitable system behavior caused by memory bugs.</Definition>
		<Definition Name="Access Final Error">Undefined or exploitable system behavior caused by access control bugs.</Definition>
		<Definition Name="Type Compute Final Error">Undefined or exploitable system behavior caused by arithmetic operation bugs.</Definition>

		<!--_INP-->
		<Definition Name="Data">A string of characters (symbols like letter, digit, punctuation) with clearly defined syntax and semantics.</Definition>

		<Definition Name="Codebase">The operation is in the programmer''s code - in the application itself.</Definition>
		<Definition Name="Third Party">The operation is in a third-party library.</Definition>
		<Definition Name="Standard Library">The operation is in the standard library for a particular programming language.</Definition>
		<Definition Name="Compiler/Interpreter">The operation is in the language processor that allows execution or creates executables (compiler, assembler, interpreter).</Definition>
		<Definition Name="Local">The bugged code runs in an environment with access control policy with limited (local user) permission.</Definition>
		<Definition Name="Admin">The bugged code runs in an environment with access control policy with unlimited (admin user) permission.</Definition>
		<Definition Name="Bare-Metal">The bugged code runs in an environment without privilege control. Usually, the program is the only software running and has total access to the hardware.</Definition>
		<Definition Name="Entered">Data comes from user interface (e.g., text field).</Definition>
		<Definition Name="Stored">Data comes from permanent storage (e.g., file, database on a storage device).</Definition>
		<Definition Name="In Use">Data comes from volatile storage (e.g., RAM, cache memory).</Definition>
		<Definition Name="Transferred">Data comes via network (e.g., connecting analog device or another computer).</Definition>
		<Definition Name="Safelist">Policy based on a set of known good content.</Definition>
		<Definition Name="Denylist">Policy based on a set of known bad content; helps reject outright maliciously malformed data.</Definition>
		<Definition Name="Format">Policy based on syntax format (e.g., defined via regular expression).</Definition>
		<Definition Name="Length">Policy based on allowed number of characters in data. Note that this is not about the data value as size of an object.</Definition>
		<Definition Name="Value">Check data for a specific value (incl. NULL or list of values).</Definition>
		<Definition Name="Quantity">Check data for a specific measurable value (e.g., size, time, rate, frequency).</Definition>
		<Definition Name="Range">Check data are within a (min, max) interval.</Definition>
		<Definition Name="Type">Check data type (e.g., int, float, XSD-XML Schema Definition, or specific structure/object).</Definition>
		<Definition Name="Other Rules">Check data against other business logic.</Definition>

		<!--_DAT-->
		<Definition Name="Object">A memory region used to store data.</Definition>
		<Definition Name="Data Value">A numeric, text, pointer/address, or boolean value stored in an object''s memory.</Definition>
		<Definition Name="Data Type">A set of allowed values and the operations allowed over them.</Definition>
		<Definition Name="Function">An organized block of code that when called takes in data, processes it, and produces a result(s).</Definition>
		<Definition Name="Primitive">Mimics the hardware units and is not built from other data types - e.g. int (long, short, signed), float, double, string, boolean.</Definition>
		<Definition Name="Structured">Builds of other data types; have members of primitive and/or structured data types - e.g. array, record, struct, union, class, interface.</Definition>
		<Definition Name="Simple">A non-polymorphic entity.</Definition>
		<Definition Name="Generics">An entity parameterized by type.</Definition>
		<Definition Name="Overloading">Functions with the same name in the same declaration scope, but implemented with different signature.</Definition>
		<Definition Name="Overriding">Functions with the same name as one in the base type, but implemented in different subtypes.</Definition>
		<Definition Name="Resolve">Look up entity name and if needed determine data type (infer from value, through hierarchy, via generic type attribute).</Definition>
		<Definition Name="Bind">Connect object data type, function return type, parameter data type, or simple function implementation.</Definition>
		<Definition Name="Early Bind">Resolve subtype and set generic function implementation.</Definition>
		<Definition Name="Late Bind">Resolve overriden function via subtype object and set implementation.</Definition>
		<Definition Name="Ad-hoc Bind">Resolve overloaded function via signature and set implementation.</Definition>
		<Definition Name="Pass In">Supply "in" arguments'' data values to a function/ operator.</Definition>
		<Definition Name="Pass Out">Supply "out" or "in/out" arguments'' data values or a return value to a function/ operator.</Definition>
		<Definition Name="Operator">A function with a symbolic name that implements a mathematical, relational or logical operation.</Definition>
		<Definition Name="Method">A member function of an OOP class.</Definition>
		<Definition Name="Lambda Expression">An anonymous function, implemented within another function.</Definition>
		<Definition Name="Procedure">A function with a void return type.</Definition>
		<Definition Name="Namespace">An organization of entities'' names, utilized to avoid names collision.</Definition>
		<Definition Name="Numeric">A number stored in an object''s memory.</Definition>
		<Definition Name="Text">A string stored in an object''s memory.</Definition>
		<Definition Name="Pointer">A holder of the memory address of an object.</Definition>
		<Definition Name="Boolean">A truth value (true or false; 1 or 0), stored in an object''s memory.</Definition>

		<!--_MEM-->
		<Definition Name="Userland">The bugged code runs in an environment with privilege levels, but in unprivileged mode (e.g., ring 3 in x86 architecture).</Definition>
		<Definition Name="Kernel">The bugged code runs in an environment with privilege levels with access privileged instructions (e.g., ring 0 in x86 architecture).</Definition>
		<Definition Name="Stack">The object is a non-static local variable (defined in a function, a passed parameters, or a function return address).</Definition>
		<Definition Name="Heap">The object is a dynamically allocated data structure (e.g., via malloc() and new).</Definition>
		<Definition Name="Direct">The operation is performed over a particular object element.</Definition>
		<Definition Name="Sequential">The operation is performed after iterating over the object elements.</Definition>
		<Definition Name="Implicit">The operation is performed without a function call.</Definition>
		<Definition Name="Explicit">The operation is performed by a function/ method) call.</Definition>
		<Definition Name="None">The object has no owner.</Definition>
		<Definition Name="Single">The object has one owner.</Definition>
		<Definition Name="Shared">The object has more than one owner.</Definition>
		<Definition Name="Little">A few bytes of memory are accessed.</Definition>
		<Definition Name="Moderate">Several bytes of memory are accessed, but less than 1 KB.</Definition>
		<Definition Name="Huge">More than 1 KB of memory is accessed.</Definition>

	</Definitions>
</BF>'

insert into bf.[ref.clusterType] (Name)
	select distinct bf.value('@Type','nvarchar(16)') from @data.nodes('BF/Cluster') X(bf);

insert into bf.[ref.operationAttribute] (Name, Definition)
	select distinct bf.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)')
	from @data.nodes('//Operations/Attribute') X(bf)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on bf.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.[ref.operationAttributeValue] (Attribute, Name, Definition)
	select distinct t.value('@Name','nvarchar(64)'), a.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)')
	from @data.nodes('//Operations/Attribute') T(t) cross apply t.nodes('Value') A(a)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on a.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.[ref.operand] (Name, Definition)
	select distinct o.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)')
	from @data.nodes('//Operands/Operand') O(o)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on o.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.[ref.operandAttribute] (Operand, Name, Definition)
	select distinct o.value('@Name','nvarchar(64)'), a.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)')
	from @data.nodes('//Operands/Operand') O(o) cross apply o.nodes('Attribute') A(a)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on a.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.[ref.operandAttributeValue] (Operand, Attribute, Name, Definition)
	select distinct o.value('@Name','nvarchar(64)'), a.value('@Name','nvarchar(64)'), n.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)')
	from @data.nodes('//Operands/Operand') O(o) cross apply o.nodes('Attribute') A(a) cross apply a.nodes('Value') N(n)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on n.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.[ref.operandError] (Name, Definition)
	select distinct t.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)')
	from @data.nodes('//Class//OperandError') T(t) 
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on t.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.[ref.operandErrorValue] (OperandError, Name, Definition)
	select distinct t.value('@Name','nvarchar(64)'), o.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)')
	from @data.nodes('//Class//OperandError') T(t) cross apply t.nodes('*') O(o)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on o.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.[ref.bug] (Name, Definition)
	select distinct b.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)')
	from @data.nodes('//Class//Bug') B(b)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on b.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.[ref.bugValue] (Bug, Name, Definition)
	select distinct t.value('@Name','nvarchar(64)'), o.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)')
	from @data.nodes('//Class//Bug') T(t) cross apply t.nodes('*') O(o)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on o.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.[ref.finalError] (Name, Definition)
	select distinct t.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)')
	from @data.nodes('//Class//FinalError') T(t) 
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on t.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.[ref.finalErrorValue] (FinalError, Name, Definition)
	select distinct t.value('@Name','nvarchar(64)'), o.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)')
	from @data.nodes('//Class//FinalError') T(t) cross apply t.nodes('*') O(o)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on o.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

--

insert into bf.cluster (Type, Name, Title, Definition, [Order])
	select bf.value('@Type','nvarchar(64)'), bf.value('@Name','nvarchar(64)'), bf.value('@Title','nvarchar(64)'), ref.value('.','nvarchar(256)'), 
	ROW_NUMBER() over (order by (select 0))
	from @data.nodes('BF/Cluster') X(bf)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on bf.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.class(Name, Cluster, Title, Definition, [Order])
	select c.value('@Name','nvarchar(64)'), bf.value('@Name','nvarchar(64)'), c.value('@Title','nvarchar(64)'), ref.value('.','nvarchar(256)'), 
	ROW_NUMBER() over (partition by bf.value('@Name','nvarchar(64)') order by (select 0))
	from @data.nodes('BF/Cluster') X(bf) cross apply bf.nodes('Class') C(c)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on c.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.operation(Class, Name, Definition, [Order])
	select c.value('@Name','nvarchar(64)'), o.value('@Name','nvarchar(64)'), ref.value('.','nvarchar(256)'), 
	ROW_NUMBER() over (partition by c.value('@Name','nvarchar(64)') order by (select 0))
	from @data.nodes('BF/Cluster/Class') C(c) cross apply c.nodes('Operations/Operation') O(o)
		left outer join @data.nodes('BF/Definitions/Definition') D(ref) on o.value('@Name','nvarchar(64)')=ref.value('@Name','nvarchar(64)');

insert into bf.operationAttribute(Class, Attribute, Name, [Order])
	select c.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)'), a.value('@Name','nvarchar(64)'), 
	ROW_NUMBER() over (partition by c.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)') order by (select 0))
	from @data.nodes('BF/Cluster/Class') C(c) cross apply c.nodes('Operations/Attribute') T(t) cross apply t.nodes('Value') A(a);

insert into bf.operand(Class, Name, [Order])
	select c.value('@Name','nvarchar(64)'), o.value('@Name','nvarchar(64)'), 
	ROW_NUMBER() over (partition by c.value('@Name','nvarchar(64)') order by (select 0))
	from @data.nodes('BF/Cluster/Class') C(c) cross apply c.nodes('Operands/Operand') O(o);

insert into bf.operandAttribute(Class, Operand, Attribute, Name, [Order])
	select c.value('@Name','nvarchar(64)'), o.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)'), a.value('@Name','nvarchar(64)'), 
	ROW_NUMBER() over (partition by c.value('@Name','nvarchar(64)'), o.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)') order by (select 0))
	from @data.nodes('BF/Cluster/Class') C(c) cross apply c.nodes('Operands/Operand') O(o)
		 cross apply o.nodes('Attribute') T(t) cross apply t.nodes('Value') A(a);

insert into bf.causeOperandError (Class, OperandError, Name, [Order])
	select c.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)'), x.value('@Name','nvarchar(64)'), 
	ROW_NUMBER() over (partition by c.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)') order by (select 0))
	from @data.nodes('BF/Cluster/Class') C(c) cross apply c.nodes('Causes/OperandError') T(t) cross apply t.nodes('Value') X(x);

insert into bf.consequenceOperandError (Class, OperandError, Name, [Order])
	select c.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)'), x.value('@Name','nvarchar(64)'), 
	ROW_NUMBER() over (partition by c.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)') order by (select 0))
	from @data.nodes('BF/Cluster/Class') C(c) cross apply c.nodes('Consequences/OperandError') T(t) cross apply t.nodes('Value') X(x);

insert into bf.fanalError(Class, FinalError, Name, [Order])
	select c.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)'), x.value('@Name','nvarchar(64)'), 
	ROW_NUMBER() over (partition by c.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)') order by (select 0))
	from @data.nodes('BF/Cluster/Class') C(c) cross apply c.nodes('Consequences/FinalError') T(t) cross apply t.nodes('Value') X(x);

insert into bf.bug(Class, Bug, Name, [Order])
	select c.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)'), x.value('@Name','nvarchar(64)'), 
	ROW_NUMBER() over (partition by c.value('@Name','nvarchar(64)'), t.value('@Name','nvarchar(64)') order by (select 0))
	from @data.nodes('BF/Cluster/Class') C(c) cross apply c.nodes('Causes/Bug') T(t) cross apply t.nodes('Value') X(x);
