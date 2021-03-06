pragma solidity ^0.5.0;

contract DStorage {
    // Name
    string public name = "DStorage";

    // Number of files
    uint256 public fileCount = 0;

    // Mapping fileId=>Struct
    mapping(uint256 => File) public files; //public-called-function-outside-smart-contract //mapping is like database like behaviour

    // Struct
    struct File {
        uint256 fileId;
        string fileHash;    //for ipfs
        uint256 fileSize;
        string fileType;        //kind of like database objects
        string fileName;
        string fileDescription;
        uint256 uploadTime;
        address payable uploader;
    }

    // Event ( Oracle )
    event FileUploaded(
        uint256 fileId,
        string fileHash,
        uint256 fileSize,
        string fileType,
        string fileName,
        string fileDescription,
        uint256 uploadTime,
        address payable uploader
    );

    constructor() public {}

    // Upload File function
    function uploadFile(
        string memory _fileHash,
        uint256 _fileSize,
        string memory _fileType,
        string memory _fileName,
        string memory _fileDescription
    ) public {
        // Make sure the file hash exists
        require(bytes(_fileHash).length > 0);

        // Make sure file type exists
        require(bytes(_fileType).length > 0);

        // Make sure file description exists
        require(bytes(_fileDescription).length > 0);

        // Make sure file fileName exists
        require(bytes(_fileName).length > 0);

        // Make sure uploader address exists
        require(msg.sender != address(0));

        // Make sure file size is more than 0
        require(_fileSize > 0);

        // Increment file id
        fileCount++;

        // Add File to the contract
        files[fileCount] = File(
            fileCount,
            _fileHash,
            _fileSize,
            _fileType,
            _fileName,
            _fileDescription,
            block.timestamp,
            msg.sender  //give address of who calling the function
        );

        // Trigger an event
        emit FileUploaded(
            fileCount,
            _fileHash,
            _fileSize,
            _fileType,
            _fileName,
            _fileDescription,
            now,    //timestamp
            msg.sender
        );
    }
}
