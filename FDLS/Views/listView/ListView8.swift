//
//  ListView8.swift
//  FDLS
//
//  Created by Mark HsieH on 2022/9/23.
//

import SwiftUI

let names = [
  "Mark",
  "John",
  "Tom",
  "Peter",
  "Bruce",
  "Roger",
  "Daniel",
  "Bill"
]

struct ListView8: View {
  @State var searchKeyword = ""
  @State var showingLoaded = false
  
  var searchResult: [String] {
    if searchKeyword.isEmpty {
      return names
    }
    return names.filter{ $0.contains(searchKeyword) }
  }

  var body: some View {
    
    List(searchResult, id:\.self) {
      Text("\($0)")
    }
    .searchable(text: $searchKeyword,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Who are you?") {
      
      Button {
        searchKeyword = "Mark"
      } label: {
        Text("你就是Mark對吧😏")
          .searchCompletion("Mark")
      }

      Button {
        searchKeyword = "Peter"
      } label: {
        Text("還是Peter🤔")
          .searchCompletion("Peter")
      }
      
    }
    .refreshable {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        showingLoaded = true
      }
    }
    .alert(isPresented: $showingLoaded) {
      Alert(title: Text("Reloaded"))
    }
    
  }
}

struct ListView8_Previews: PreviewProvider {
  static var previews: some View {
    ListView8()
  }
}
