pragma solidity ^0.5.16;


contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;  // unsigned integer
        string name;
        uint voteCount;
        int roll;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Read/write candidates
    mapping(uint => Candidate) public candidates;
    // solidity allows a candidates function that allows to fetch our candidates from the mapping
    //in solidity ,there is no way tiso iterate over mapping or know the size of it so we used candidatesCount
    // Store Candidates Count
    uint public candidatesCount;

// voted event
event votedEvent(
uint indexed _candidateId
);

    function addCandidate (string memory _name, int _roll, string memory _post) public {
        if(keccak256(abi.encodePacked((_post)))==keccak256("General Secretary, Culturals"))
        {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0 , _roll  );
        }
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        //trigger voted event
        emit votedEvent(_candidateId);
    }
}