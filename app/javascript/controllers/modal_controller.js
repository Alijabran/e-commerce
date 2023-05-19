import { Controller } from "@hotwired/stimulus"

export default class extends Controller { 
  open(event){
    let deleteLink = document.getElementById('deleteLink');
    deleteLink.href = deleteLink.href.replace(/\d+(?!.*\d+)/, event.target.dataset.userId);
    $('#myModal').modal('show');
  }

  close(){
    $('#myModal').modal('hide');
  }
}
