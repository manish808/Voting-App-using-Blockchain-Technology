pragma solidity ^0.5.16;


contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;  // unsigned integer
        string name;
        uint voteCount;
        int roll;
        string Position;
        uint SerialNumber;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Read/write candidates
    mapping(uint => Candidate) public candidates;
    // solidity allows a candidates function that allows to fetch our candidates from the mapping
    //in solidity ,there is no way tiso iterate over mapping or know the size of it so we used candidatesCount
    // Store Candidates Count
    uint public candidatesCount;
    uint public PresidentCount;
    uint public CulturalsCount;
    uint public AcademicsCount;
    uint public HostelCount;
    uint public voters2;

// voted event
event votedEvent(
uint indexed _candidateId
);

    constructor () public {
      addCandidate ("NOTA", 0 , "General Secretary, Culturals");
      addCandidate ("NOTA", 0 , "General Secretary, President");
      addCandidate ("NOTA", 0 ,"General Secretary, Hostel Affairs" );
      addCandidate ("NOTA", 0 ,  "General Secretary, Academics" );
    }


    function addCandidate (string memory _name, int _roll, string memory _post) public {
        candidatesCount++;
        if(keccak256(abi.encodePacked((_post)))==keccak256("General Secretary, Culturals"))
        {
        CulturalsCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount , _name, 0 , _roll, _post , CulturalsCount);
        }
        else if(keccak256(abi.encodePacked((_post)))==keccak256("General Secretary, President"))
        {
        PresidentCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0 , _roll, _post , PresidentCount);
        }
        else if(keccak256(abi.encodePacked((_post)))==keccak256("General Secretary, Hostel Affairs"))
        {
        HostelCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0 , _roll, _post , HostelCount );
        }
        else if(keccak256(abi.encodePacked((_post)))==keccak256("General Secretary, Academics"))
        {
        AcademicsCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0 , _roll, _post , AcademicsCount );
        }
    }

    function vote (uint _candidateId,string memory _post) public {
        // require that they haven't voted before
      //  require(!voters[msg.sender]);

        // require a valid candidate
        //require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;
        voters2++;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        //trigger voted event
        if(voters2%4 == 0) {
          emit votedEvent(_candidateId);
        }
    }
}